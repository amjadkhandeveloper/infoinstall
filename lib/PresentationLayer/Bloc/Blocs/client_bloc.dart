// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

import '../../../DomainLayer/Entities/Client_entity.dart';
import '../../Components/constant.dart';
import '../Events/client_event.dart';
import '../States/client_state.dart';

// Importing custom event and state classes for the ClientBloc

// BLoC class for handling state management related to fetching and displaying Clients
class ClientBloc extends Bloc<ClientEvent, ClientState> {
  // ClientBloc(super.initialState);

  //Constructor initializes the ClientBloc with the initial state and sets up event handling
  ClientBloc() : super(InitialClientState()) {
    on<FetchClient>(_fetchClient);
  }

  // Private method for handling the FetchClient event and updating the state accordingly
  _fetchClient(ClientEvent event, Emitter<ClientState> emit) async {
    // Checking if the event is of type FetchClient
    if (event is FetchClient) {
      // Emitting a loading state to indicate that the Client is being fetched
      emit(ClientLoading());
      try {
        Logger("Client id is ${event.clientID} ");
        // Making an HTTP POST request to the quotable.io API to fetch a random Client
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url =
            "$infoInstallProductionURL$clientListApi${event.clientID}";
        logHttpRequest('GET', url);
        final response = await httpClient.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json', // Specify the content type here
          },
        );
        // Checking if the response status code is OK (200)
        if (response.statusCode == 200) {
          // Decoding the JSON response and creating a ClientLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          Logger(response.body);
          ClientDetails clientDetails = ClientDetails.fromJson(decodedResponse);

          final client = ClientLoaded(
            stauts: clientDetails.status,
            clientDetailsModel: clientDetails.data,
            error: [],
          );

          // Emitting the ClientLoaded state to update the UI with the fetched Client
          emit(client);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a ClientLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          ClientDetails clientDetails = ClientDetails.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final client = ClientError(
            clientDetails.message.toString(),
          );

          // Emitting the ClientLoaded state to update the UI with the fetched Client
          emit(client);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(ClientError('Failed to load Client'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(ClientError('Error: $e'));
      }
    }
  }
}
