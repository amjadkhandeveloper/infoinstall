// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/DomainLayer/Entities/remove_device_entitiy.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/remove_device_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/remove_device_state.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

import '../../Components/constant.dart';

// Importing custom event and state classes for the RemoveDeviceBloc

// BLoC class for handling state management related to fetching and displaying RemoveDevices
class RemoveDeviceBloc extends Bloc<RemoveDeviceEvent, RemoveDeviceState>
    with PrintMixin {
  // RemoveDeviceBloc(super.initialState);

  //Constructor initializes the RemoveDeviceBloc with the initial state and sets up event handling
  RemoveDeviceBloc() : super(InitialRemoveDeviceState()) {
    on<RemoveDevice>(_doRemoveDevice);
  }

  // Private method for handling the FetchRemoveDevice event and updating the state accordingly
  _doRemoveDevice(
      RemoveDeviceEvent event, Emitter<RemoveDeviceState> emit) async {
    // Checking if the event is of type FetchRemoveDevice
    if (event is RemoveDevice) {
      // Emitting a loading state to indicate that the RemoveDevice is being fetched
      emit(RemoveDeviceLoading());
      try {
        p("called api");
        Logger("RemoveDevice id is ${event.requestString} ");
        // Making an HTTP POST request to the quotable.io API to fetch a random RemoveDevice
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url = "$infoInstallProductionURL$jobDeviceDelete";
        logHttpRequest('DELETE', url, body: event.requestString);
        final response = await httpClient.delete(Uri.parse(url),
            headers: {
              'Content-Type':
                  'application/json', // Specify the content type here
            },
            body: event.requestString //jsonEncode(),
            );
        logHttpResponse(response.statusCode, url, body: response.body);
        // Checking if the response status code is OK (200)
        if (response.statusCode == 200) {
          // Decoding the JSON response and creating a RemoveDeviceLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          p(response.body);
          RemoveDeviceDetails removeDeviceDetails =
              RemoveDeviceDetails.fromJson(decodedResponse);

          final removeDevice = RemoveDeviceLoaded(
            stauts: removeDeviceDetails.status,
            message: removeDeviceDetails.message,
            error: [],
          );

          // Emitting the RemoveDeviceLoaded state to update the UI with the fetched RemoveDevice
          emit(removeDevice);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a RemoveDeviceLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          RemoveDeviceDetails removeDeviceDetails =
              RemoveDeviceDetails.fromJson(decodedResponse);

          final removeDevice = RemoveDeviceError(
            removeDeviceDetails.message.toString(),
          );

          // Emitting the RemoveDeviceLoaded state to update the UI with the fetched RemoveDevice
          emit(removeDevice);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(RemoveDeviceError('Failed to load RemoveDevice'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(RemoveDeviceError('Error: $e'));
      }
    }
  }
}
