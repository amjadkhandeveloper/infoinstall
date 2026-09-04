// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../Bloc/Blocs/client_bloc.dart';
import '../Bloc/Events/client_event.dart';
import '../Bloc/States/client_state.dart';
import '../Components/color_plattes.dart';
import '../Widgets/Client_item_widget.dart';

class ClientListScreen extends StatefulWidget {
  final String title;
  final String clientId;
  const ClientListScreen(
      {super.key, required this.title, required this.clientId});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  late ClientBloc _clientBloc; // Declare the ClientBloc
  late bool result = true;
  @override
  void initState() {
    super.initState();
    _clientBloc = ClientBloc(); // Initialize the ClientBloc
    checkInternetConnection();
  }

  @override
  void dispose() {
    _clientBloc.close(); // Close the bloc when not needed
    super.dispose();
  }

  Future<void> checkInternetConnection() async {
    result = await InternetConnection().hasInternetAccess;
    if (result) {
      _clientBloc.add(FetchClient(
          clientID: widget.clientId)); // Trigger the FetchClient event
    }
    setState(() {}); // Update UI on change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: ColorsPlatte.lightgreenshede),
        ),
        backgroundColor: ColorsPlatte.accentColor,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ClientBloc, ClientState>(
        bloc: _clientBloc,
        builder: (context, state) {
          if (state is ClientLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClientLoaded) {
            return result
                ? ListView.builder(
                    itemCount: state.clientDetailsModel.length,
                    itemBuilder: (context, index) {
                      final client = state.clientDetailsModel[index];
                      return ClientListItem(
                        clientDetailsModel: client,
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'No internet connection!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await checkInternetConnection();
                          },
                          //initConnectivity(),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
          } else if (state is ClientError) {
            return Center(child: Text(state.errorMessage));
          } else {
            if (result) {
              return const Center(
                child: Text('Please wait'),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'No internet connection!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await checkInternetConnection();
                      },
                      //initConnectivity(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
