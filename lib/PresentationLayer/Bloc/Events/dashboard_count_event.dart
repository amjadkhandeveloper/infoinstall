// Abstract base class for defining loign-related events

abstract class DashboardCountEvent {}

//Date=2024-03-21&UserID=87
// Event class for triggering the fetching login details valid
class FetchDashboardCount extends DashboardCountEvent {
  final String currentDate;
  final int userID;

  FetchDashboardCount({required this.currentDate, required this.userID});
}
