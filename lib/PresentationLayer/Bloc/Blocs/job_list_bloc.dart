// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

import '../../../DomainLayer/Entities/job_list_entity.dart';
import '../../Components/constant.dart';
import '../Events/job_list_event.dart';
import '../States/job_list_state.dart';

// Importing custom event and state classes for the JobListBloc

// BLoC class for handling state management related to fetching and displaying JobLists
class JobListBloc extends Bloc<JobListEvent, JobListState> {
  // JobListBloc(super.initialState);

  //Constructor initializes the JobListBloc with the initial state and sets up event handling
  JobListBloc() : super(InitialJobListState()) {
    on<FetchJobList>(_fetchJobList);
  }

  // Private method for handling the FetchJobList event and updating the state accordingly
  _fetchJobList(JobListEvent event, Emitter<JobListState> emit) async {
    // Checking if the event is of type FetchJobList
    if (event is FetchJobList) {
      // Emitting a loading state to indicate that the JobList is being fetched
      emit(JobListLoading());
      try {
        Logger("JobList id is ${event.jobListID} ");
        // Making an HTTP POST request to the quotable.io API to fetch a random JobList
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url =
            "$infoInstallProductionURL$jobListApi${event.currentDate}$jobUserIdApi${event.userID}$jobStatusApi${event.jobListID}";
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
          // Decoding the JSON response and creating a JobListLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          Logger(response.body);
          JobListDetails jobListDetails =
              JobListDetails.fromJson(decodedResponse);

          final jobList = JobListLoaded(
            stauts: jobListDetails.status,
            jobListDetailsModel: jobListDetails.data,
            error: [],
          );

          // Emitting the JobListLoaded state to update the UI with the fetched JobList
          emit(jobList);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a JobListLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          JobListDetails jobListDetails =
              JobListDetails.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final jobList = JobListError(
            jobListDetails.message.toString(),
          );

          // Emitting the JobListLoaded state to update the UI with the fetched JobList
          emit(jobList);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(JobListError('Failed to load JobList'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(JobListError('Error: $e'));
      }
    }
  }
}
