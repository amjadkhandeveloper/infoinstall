// Abstract base class for defining DashboardCoutnt-related states
import '../../../DataLayer/Model/dashbaord_item.dart';
import '../../../DataLayer/Model/data_error.dart';

abstract class DashboardCountState {}

// Subclass representing the initial state.
class InitialDashboardCountState extends DashboardCountState {}

// State class indicating that a DashboardCoutnt is currently being fetched
class DashboardCountLoading extends DashboardCountState {}

// State class representing a successfully loaded DashboardCoutnt with content, author, tags, and date added
class DashboardCountLoaded extends DashboardCountState {
  final int? stauts;
  final List<DashboardCountDetailsModel> dashboardCountDetailsModel;
  final List<DataError?> error;

  // Constructor for creating a DashboardCoutntLoaded instance with required data
  DashboardCountLoaded({
    required this.stauts,
    required this.dashboardCountDetailsModel,
    required this.error,
  });
}

// State class representing an error in the DashboardCoutnt fetching process with an error message
class DashboardCountError extends DashboardCountState {
  final String errorMessage;

  // Constructor for creating a DashboardCoutntError instance with the provided error message
  DashboardCountError(this.errorMessage);
}
