// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:logging/logging.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';

import '../../../DomainLayer/Entities/device_entity.dart';
import '../../Components/constant.dart';
import '../Events/device_list_event.dart';
import '../States/device_list_state.dart';

// Importing custom event and state classes for the DeviceListBloc

// BLoC class for handling state management related to fetching and displaying DeviceLists
class DeviceListBloc extends Bloc<DeviceListEvent, DeviceListState> {
  // DeviceListBloc(super.initialState);

  //Constructor initializes the DeviceListBloc with the initial state and sets up event handling
  DeviceListBloc() : super(InitialDeviceListState()) {
    on<FetchDeviceList>(_fetchDeviceList);
  }

  // Private method for handling the FetchDeviceList event and updating the state accordingly
  _fetchDeviceList(DeviceListEvent event, Emitter<DeviceListState> emit) async {
    // Checking if the event is of type FetchDeviceList
    if (event is FetchDeviceList) {
      // Emitting a loading state to indicate that the DeviceList is being fetched
      emit(DeviceListLoading());
      try {
        Logger("DeviceList job id is ${event.jobID} ");
        // Making an HTTP POST request to the quotable.io API to fetch a random DeviceList
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url =
            "$infoInstallProductionURL$deviceListApi${event.jobID}&UserID=${event.userID}";
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
          // Decoding the JSON response and creating a DeviceListLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          Logger(response.body);
          DeviceListDetails deviceListDetails =
              DeviceListDetails.fromJson(decodedResponse);

          final deviceList = DeviceListLoaded(
            stauts: deviceListDetails.status,
            deviceListDetailsModel: deviceListDetails.data,
            error: [],
          );

          // Emitting the DeviceListLoaded state to update the UI with the fetched DeviceList
          emit(deviceList);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a DeviceListLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          DeviceListDetails deviceListDetails =
              DeviceListDetails.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final deviceList = DeviceListError(
            deviceListDetails.message.toString(),
          );

          // Emitting the DeviceListLoaded state to update the UI with the fetched DeviceList
          emit(deviceList);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(DeviceListError('Failed to load DeviceList'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(DeviceListError('Error: $e'));
      }
    }
  }
}
