// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/checkout_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/checkout_state.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';
import '../../../DomainLayer/Entities/checkout_entity.dart';
import '../../Components/constant.dart';

// Importing custom event and state classes for the CheckOutBloc

// BLoC class for handling state management related to fetching and displaying CheckOuts
class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> with PrintMixin {
  // CheckOutBloc(super.initialState);

  //Constructor initializes the CheckOutBloc with the initial state and sets up event handling
  CheckOutBloc() : super(InitialCheckOutState()) {
    on<DoCheckOut>(_doCheckOut);
  }

  // Private method for handling the FetchCheckOut event and updating the state accordingly
  _doCheckOut(CheckOutEvent event, Emitter<CheckOutState> emit) async {
    // Checking if the event is of type FetchCheckOut
    if (event is DoCheckOut) {
      // Emitting a loading state to indicate that the CheckOut is being fetched
      emit(CheckOutLoading());
      try {
        p("called api ${event.requestString} ");
        if (event.requestType == 0) {
          const String url = "$infoInstallProductionURL$jobDeviceUpdate";
          logHttpRequest('POST', url, body: event.requestString);

          final ioc = HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
          final httpClient = IOClient(ioc);
          final response = await httpClient.post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
              },
              body: event.requestString);
          logHttpResponse(response.statusCode, url, body: response.body);
          // Checking if the response status code is OK (200)
          if (response.statusCode == 200) {
            // Decoding the JSON response and creating a CheckOutLoaded state with the retrieved data
            final Map<String, dynamic> decodedResponse =
                jsonDecode(response.body);
            Logger(response.body);
            CheckOutDetails checkOutDetails =
                CheckOutDetails.fromJson(decodedResponse);

            final checkOut = CheckOutLoaded(
              stauts: checkOutDetails.status,
              message: checkOutDetails.message,
              error: [],
            );
            p(checkOut.message.toString());
            if (checkOut.stauts == 400) {
              emit(CheckOutError('Error: ${checkOut.message.toString()} '));
            } else {
              // Emitting the CheckOutLoaded state to update the UI with the fetched CheckOut
              emit(checkOut);
            }
          } else if (response.statusCode == 400) {
            // Decoding the JSON response and creating a CheckOutLoaded state with the retrieved data
            // final Map<String, dynamic> decodedResponse =
            //     jsonDecode(response.body);
            // CheckOutDetails checkOutDetails =
            //     CheckOutDetails.fromJson(decodedResponse);

            // final checkOut = CheckOutError(
            //   checkOutDetails.message.toString(),
            // );

            // Emitting the CheckOutLoaded state to update the UI with the fetched CheckOut
            emit(CheckOutError('Failed to load CheckOut'));
          } else {
            // Emitting an error state if the response status code is not OK
            emit(CheckOutError('Failed to load CheckOut'));
          }
        } else {
          // Making an HTTP POST request to the quotable.io API to fetch a random CheckOut
          final ioc = HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
          final httpClient = IOClient(ioc);
          const String url = "$infoInstallProductionURL$jobUnitImageUpdate";
          logHttpRequest('POST', url, body: event.requestString);
          final response = await httpClient.post(Uri.parse(url),
              headers: {
                'Content-Type':
                    'application/json', // Specify the content type here
              },
              body: event.requestString //jsonEncode(),
              );
          logHttpResponse(response.statusCode, url, body: response.body);
          // Checking if the response status code is OK (200)
          if (response.statusCode == 200) {
            // Decoding the JSON response and creating a CheckOutLoaded state with the retrieved data
            final Map<String, dynamic> decodedResponse =
                jsonDecode(response.body);
            Logger(response.body);
            CheckOutDetails checkOutDetails =
                CheckOutDetails.fromJson(decodedResponse);

            final checkOut = CheckOutImageUploaded(
              stauts: checkOutDetails.status,
              message: checkOutDetails.message,
              error: [],
            );
            p(checkOut.message.toString());
            if (checkOut.stauts == 400) {
              emit(CheckOutError('Error: ${checkOut.message.toString()} '));
            } else {
              // Emitting the CheckOutLoaded state to update the UI with the fetched CheckOut
              emit(checkOut);
            }
          } else if (response.statusCode == 400) {
            // Decoding the JSON response and creating a CheckOutLoaded state with the retrieved data
            // final Map<String, dynamic> decodedResponse =
            //     jsonDecode(response.body);
            // CheckOutDetails checkOutDetails =
            //     CheckOutDetails.fromJson(decodedResponse);

            // final checkOut = CheckOutError(
            //   checkOutDetails.message.toString(),
            // );

            // Emitting the CheckOutLoaded state to update the UI with the fetched CheckOut
            emit(CheckOutError('Failed to load CheckOut'));
          } else {
            // Emitting an error state if the response status code is not OK
            emit(CheckOutError('Failed to load CheckOut'));
          }
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(CheckOutError('Error: $e'));
      }
    }
  }
}
