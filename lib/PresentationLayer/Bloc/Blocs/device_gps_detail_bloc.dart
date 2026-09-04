// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/device_gps_detail_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/device_gps_detail_state.dart';
import 'package:logging/logging.dart';
import 'package:infoinstall/DomainLayer/Entities/device_gps_entity.dart';
import '../../Components/constant.dart';

// Importing custom event and state classes for the DeviceGpsDetailBloc

// BLoC class for handling state management related to fetching and displaying DeviceGpsDetails
class DeviceGpsDetailBloc
    extends Bloc<DeviceGpsDetailEvent, DeviceGpsDetailState> {
  // DeviceGpsDetailBloc(super.initialState);

  //Constructor initializes the DeviceGpsDetailBloc with the initial state and sets up event handling
  DeviceGpsDetailBloc() : super(InitialDeviceGpsDetailState()) {
    on<FetchDeviceGpsDetail>(_fetchDeviceGpsDetail);
  }

  // Private method for handling the FetchDeviceGpsDetail event and updating the state accordingly
  _fetchDeviceGpsDetail(
      DeviceGpsDetailEvent event, Emitter<DeviceGpsDetailState> emit) async {
    // Checking if the event is of type FetchDeviceGpsDetail
    if (event is FetchDeviceGpsDetail) {
      // Emitting a loading state to indicate that the DeviceGpsDetail is being fetched
      emit(DeviceGpsDetailLoading());
      try {
        Logger(
            "DeviceGpsDetail Unitno is ${event.unitno} Simno is ${event.simNo}");
        // Making an HTTP POST request to the quotable.io API to fetch a random DeviceGpsDetail
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url =
            "$infoInstallProductionURL$deviceGpsDetailApi${event.unitno}&SimNo=${event.simNo}";
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
          // Decoding the JSON response and creating a DeviceGpsDetailLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          Logger(response.body);

          DeviceGpsDetailEntity deviceListDetails =
              DeviceGpsDetailEntity.fromJson(decodedResponse);

          final deviceGpsDetail = DeviceGpsDetailLoaded(
            stauts: deviceListDetails.status,
            deviceGpsDetailModel: deviceListDetails.data,
            error: [],
          );

          // Emitting the DeviceGpsDetailLoaded state to update the UI with the fetched DeviceGpsDetail
          emit(deviceGpsDetail);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a DeviceGpsDetailLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);

          DeviceGpsDetailEntity deviceListDetails =
              DeviceGpsDetailEntity.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final deviceGpsDetail = DeviceGpsDetailError(
            deviceListDetails.message.toString(),
          );

          // Emitting the DeviceGpsDetailLoaded state to update the UI with the fetched DeviceGpsDetail
          emit(deviceGpsDetail);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(DeviceGpsDetailError('Failed to load DeviceGpsDetail'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(DeviceGpsDetailError('Error: $e'));
      }
    }
  }
}
