// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';

import '../../../DomainLayer/Entities/dashboard_entity.dart';
import '../../Components/constant.dart';
import '../Events/dashboard_count_event.dart';
import '../States/dashobard_count_state.dart';
// Importing custom event and state classes for the DashboardCountBloc

// BLoC class for handling state management related to fetching and displaying DashboardCounts
class DashboardCountBloc extends Bloc<DashboardCountEvent, DashboardCountState>
    with PrintMixin {
  // DashboardCountBloc(super.initialState);

  //Constructor initializes the DashboardCountBloc with the initial state and sets up event handling
  DashboardCountBloc() : super(InitialDashboardCountState()) {
    on<FetchDashboardCount>(_fetchDashboardCount);
  }

  // Private method for handling the FetchDashboardCount event and updating the state accordingly
  _fetchDashboardCount(
      DashboardCountEvent event, Emitter<DashboardCountState> emit) async {
    // Checking if the event is of type FetchDashboardCount
    if (event is FetchDashboardCount) {
      p('fetching dashboard data');
      // Emitting a loading state to indicate that the DashboardCount is being fetched
      emit(DashboardCountLoading());
      try {
        p("UserId id is ${event.userID} ");
        // Making an HTTP POST request to the quotable.io API to fetch a random DashboardCount
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url =
            "$infoInstallProductionURL$dashbaordApi${event.currentDate}$dahboardUserId${event.userID}";
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
          // Decoding the JSON response and creating a DashboardCountLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          p(response.body);
          DashboardCountDetails dashboardCountDetails =
              DashboardCountDetails.fromJson(decodedResponse);

          final dashboardCount = DashboardCountLoaded(
            stauts: dashboardCountDetails.status,
            dashboardCountDetailsModel:
                dashboardCountDetails.datefilterjobcount,
            error: [],
          );

          // Emitting the DashboardCountLoaded state to update the UI with the fetched DashboardCount
          emit(dashboardCount);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a DashboardCountLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          DashboardCountDetails dashboardCountDetails =
              DashboardCountDetails.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final dashboardCount = DashboardCountError(
            dashboardCountDetails.message.toString(),
          );

          // Emitting the DashboardCountLoaded state to update the UI with the fetched DashboardCount
          emit(dashboardCount);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(DashboardCountError('Failed to load Dashboard'));
        }
      } catch (e) {
        p("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(DashboardCountError('Failed to load Dashboard'));
      }
    }
  }
}
