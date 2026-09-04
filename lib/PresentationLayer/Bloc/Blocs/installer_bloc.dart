// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

import '../../../DomainLayer/Entities/Installer_entity.dart';
import '../../Components/constant.dart';
import '../Events/Installer_event.dart';
import '../States/Installer_state.dart';

// Importing custom event and state classes for the InstallerBloc

// BLoC class for handling state management related to fetching and displaying Installers
class InstallerBloc extends Bloc<InstallerEvent, InstallerState> {
  // InstallerBloc(super.initialState);

  //Constructor initializes the InstallerBloc with the initial state and sets up event handling
  InstallerBloc() : super(InitialInstallerState()) {
    on<FetchInstaller>(_fetchInstaller);
  }

  // Private method for handling the FetchInstaller event and updating the state accordingly
  _fetchInstaller(InstallerEvent event, Emitter<InstallerState> emit) async {
    // Checking if the event is of type FetchInstaller
    if (event is FetchInstaller) {
      // Emitting a loading state to indicate that the Installer is being fetched
      emit(InstallerLoading());
      try {
        Logger("Installer id is ${event.installerID} ");
        // Making an HTTP POST request to the quotable.io API to fetch a random Installer
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url =
            "$infoInstallProductionURL$installerListApi${event.installerID}";
        logHttpRequest('GET', url);
        final response = await httpClient.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json', // Specify the content type here
          },
        );
        logHttpResponse(response.statusCode, url, body: response.body);
        // Checking if the response status code is OK (200)
        if (response.statusCode == 200) {
          // Decoding the JSON response and creating a InstallerLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          Logger(response.body);
          InstallerDetails installerDetails =
              InstallerDetails.fromJson(decodedResponse);

          final installer = InstallerLoaded(
            stauts: installerDetails.status,
            installerDetailsModel: installerDetails.data,
            error: [],
          );

          // Emitting the InstallerLoaded state to update the UI with the fetched Installer
          emit(installer);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a InstallerLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          InstallerDetails installerDetails =
              InstallerDetails.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final installer = InstallerError(
            installerDetails.message.toString(),
          );

          // Emitting the InstallerLoaded state to update the UI with the fetched Installer
          emit(installer);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(InstallerError('Failed to load Installer'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(InstallerError('Error: $e'));
      }
    }
  }
}
