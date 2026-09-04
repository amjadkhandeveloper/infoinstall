import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../Bloc/Blocs/installer_bloc.dart';
import '../Bloc/Events/Installer_event.dart';
import '../Bloc/States/Installer_state.dart';
import '../Components/color_plattes.dart';
import '../Widgets/Installer_item_widget.dart'; // Updated import

class InstallerListScreen extends StatefulWidget {
  // Updated class name
  final String title;

  const InstallerListScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<InstallerListScreen> createState() =>
      _InstallerListScreenState(); // Updated state class name
}

class _InstallerListScreenState extends State<InstallerListScreen> {
  // Updated state class name
  late final InstallerBloc _installerBloc;
  late bool result = true;
  @override
  void initState() {
    super.initState();
    _installerBloc = InstallerBloc();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    result = await InternetConnection().hasInternetAccess;
    if (result) {
      _installerBloc.add(
          FetchInstaller(installerID: "0")); // Fetching installer with ID 86
    }
    setState(() {}); // Update UI on change
  }

  @override
  void dispose() {
    _installerBloc.close();
    super.dispose();
  }

  // Updated state class name
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
      body: BlocBuilder<InstallerBloc, InstallerState>(
        bloc: _installerBloc,
        builder: (context, state) {
          if (state is InstallerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InstallerLoaded) {
            return result
                ? ListView.builder(
                    itemCount: state.installerDetailsModel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {},
                        child: InstallerListItem(
                          // Updated widget name
                          installerName:
                              state.installerDetailsModel[index].employeeName,
                          mobileNumber:
                              state.installerDetailsModel[index].mobileNO,
                        ),
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
          } else if (state is InstallerError) {
            return Center(
              child: Text(state.errorMessage),
            );
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
