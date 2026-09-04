// Abstract base class for defining DashboardCoutnt-related states
import '../../../DataLayer/Model/data_error.dart';
import '../../../DataLayer/Model/job_summary_item.dart';

abstract class JobSummaryState {}

// Subclass representing the initial state.
class InitialJobSummaryState extends JobSummaryState {}

// State class indicating that a DashboardCoutnt is currently being fetched
class JobSummaryLoading extends JobSummaryState {}

// State class representing a successfully loaded DashboardCoutnt with content, author, tags, and date added
class JobSummaryLoaded extends JobSummaryState {
  final int? stauts;
  final List<JobSummaryDetailsModel> jobSummaryDetailsModel;
  final List<DataError?> error;

  // Constructor for creating a DashboardCoutntLoaded instance with required data
  JobSummaryLoaded({
    required this.stauts,
    required this.jobSummaryDetailsModel,
    required this.error,
  });
}

// State class representing an error in the DashboardCoutnt fetching process with an error message
class JobSummaryError extends JobSummaryState {
  final String errorMessage;

  // Constructor for creating a DashboardCoutntError instance with the provided error message
  JobSummaryError(this.errorMessage);
}
