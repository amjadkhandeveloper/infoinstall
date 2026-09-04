// Abstract base class for defining loign-related events
abstract class JobListEvent {}

// Event class for triggering the fetching login details valid
class FetchJobList extends JobListEvent {
  final String currentDate;
  final String userID;
  final String jobListID;

  FetchJobList({
    required this.currentDate,
    required this.userID,
    required this.jobListID,
  });
}
