// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

import '../../../DomainLayer/Entities/job_summary_entity.dart';
import '../../Components/constant.dart';
import '../Events/job_summary_event.dart';
import '../States/job_summary_state.dart';

// Importing custom event and state classes for the JobSummaryBloc

// BLoC class for handling state management related to fetching and displaying JobSummarys
class JobSummaryBloc extends Bloc<JobSummaryEvent, JobSummaryState> {
  // JobSummaryBloc(super.initialState);

  //Constructor initializes the JobSummaryBloc with the initial state and sets up event handling
  JobSummaryBloc() : super(InitialJobSummaryState()) {
    on<FetchJobSummary>(_fetchJobSummary);
  }

  // Private method for handling the FetchJobSummary event and updating the state accordingly
  _fetchJobSummary(JobSummaryEvent event, Emitter<JobSummaryState> emit) async {
    // Checking if the event is of type FetchJobSummary
    if (event is FetchJobSummary) {
      // Emitting a loading state to indicate that the JobSummary is being fetched
      emit(JobSummaryLoading());
      try {
        Logger("JobSummary id is ${event.currentDate} ");
        // Making an HTTP POST request to the quotable.io API to fetch a random JobSummary
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
          // Decoding the JSON response and creating a JobSummaryLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          Logger(response.body);
          JobSummaryDetails jobSummaryDetails =
              JobSummaryDetails.fromJson(decodedResponse);

          final jobSummary = JobSummaryLoaded(
            stauts: jobSummaryDetails.status,
            jobSummaryDetailsModel: jobSummaryDetails.todaysjobcount,
            error: [],
          );

          // Emitting the JobSummaryLoaded state to update the UI with the fetched JobSummary
          emit(jobSummary);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a JobSummaryLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          JobSummaryDetails jobSummaryDetails =
              JobSummaryDetails.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final jobSummary = JobSummaryError(
            jobSummaryDetails.message.toString(),
          );

          // Emitting the JobSummaryLoaded state to update the UI with the fetched JobSummary
          emit(jobSummary);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(JobSummaryError('Failed to load JobSummary'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(JobSummaryError('Error: $e'));
      }
    }
  }
}
