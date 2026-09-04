// Abstract base class for defining JobList-related states
import '../../../DataLayer/Model/data_error.dart';
import '../../../DataLayer/Model/job_list_item_model.dart';

abstract class JobListState {}

// Subclass representing the initial state.
class InitialJobListState extends JobListState {}

// State class indicating that a JobList is currently being fetched
class JobListLoading extends JobListState {}

// State class representing a successfully loaded JobList with content, author, tags, and date added
class JobListLoaded extends JobListState {
  final int? stauts;
  final List<JobListDetailsModel> jobListDetailsModel;
  final List<DataError?> error;

  // Constructor for creating a JobListLoaded instance with required data
  JobListLoaded({
    required this.stauts,
    required this.jobListDetailsModel,
    required this.error,
  });
}

// State class representing an error in the JobList fetching process with an error message
class JobListError extends JobListState {
  final String errorMessage;

  // Constructor for creating a JobListError instance with the provided error message
  JobListError(this.errorMessage);
}
