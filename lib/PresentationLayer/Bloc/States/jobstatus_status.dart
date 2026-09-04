// Abstract base class for defining JobStatus-related states
import '../../../DataLayer/Model/data_error.dart';

abstract class JobStatusState {}

// Subclass representing the initial state.
class InitialJobStatusState extends JobStatusState {}

// State class indicating that a JobStatus is currently being fetched
class JobStatusLoading extends JobStatusState {}

// State class representing a successfully loaded JobStatus with content, author, tags, and date added
class JobStatusLoaded extends JobStatusState {
  final int? stauts;
  final String? message;
  final int jobStatusId;
  final List<DataError?> error;

  // Constructor for creating a JobStatusLoaded instance with required data
  JobStatusLoaded({
    required this.stauts,
    required this.message,
    required this.jobStatusId,
    required this.error,
  });
}

// State class representing an error in the JobStatus fetching process with an error message
class JobStatusError extends JobStatusState {
  final String errorMessage;

  // Constructor for creating a JobStatusError instance with the provided error message
  JobStatusError(this.errorMessage);
}
