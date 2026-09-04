// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

import '../../../DomainLayer/Entities/JobStatus_entity.dart';
import '../../Components/constant.dart';
import '../Events/jobstatus_event.dart';
import '../States/jobstatus_status.dart';

// Importing custom event and state classes for the JobStatusBloc

// BLoC class for handling state management related to fetching and displaying JobStatuss
class JobStatusBloc extends Bloc<JobStatusEvent, JobStatusState>
    with PrintMixin {
  // JobStatusBloc(super.initialState);

  //Constructor initializes the JobStatusBloc with the initial state and sets up event handling
  JobStatusBloc() : super(InitialJobStatusState()) {
    on<UpdateJobStatus>(_doJobStatus);
  }

  // Private method for handling the FetchJobStatus event and updating the state accordingly
  _doJobStatus(JobStatusEvent event, Emitter<JobStatusState> emit) async {
    // Checking if the event is of type FetchJobStatus
    if (event is UpdateJobStatus) {
      // Emitting a loading state to indicate that the JobStatus is being fetched
      emit(JobStatusLoading());
      try {
        Logger("JobStatus id is ${event.requestString} ");
        p('request string ${event.requestString} and url $infoInstallProductionURL$jobStatusUpdate');
        // Making an HTTP POST request to the quotable.io API to fetch a random JobStatus
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url = "$infoInstallProductionURL$jobStatusUpdate";
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
          // Decoding the JSON response and creating a JobStatusLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          Logger(response.body);
          JobStatusDetails jobStatusDetails =
              JobStatusDetails.fromJson(decodedResponse);

          final jobStatus = JobStatusLoaded(
            stauts: jobStatusDetails.status,
            message: jobStatusDetails.message,
            jobStatusId: event.jobStatusId,
            error: [],
          );

          p(jobStatus.message.toString());
          if (jobStatus.stauts == 400) {
            emit(JobStatusError(': ${jobStatus.message.toString()} '));
          } else {
            // Emitting the CheckOutLoaded state to update the UI with the fetched CheckOut
            emit(jobStatus);
          }

          // Emitting the JobStatusLoaded state to update the UI with the fetched JobStatus
          // emit(JobStatus);
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a JobStatusLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          JobStatusDetails jobStatusDetails =
              JobStatusDetails.fromJson(decodedResponse);

          final jobStatus = JobStatusError(
            jobStatusDetails.message.toString(),
          );

          // Emitting the JobStatusLoaded state to update the UI with the fetched JobStatus
          emit(jobStatus);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(JobStatusError('Failed to load JobStatus'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(JobStatusError('Error: $e'));
      }
    }
  }
}
