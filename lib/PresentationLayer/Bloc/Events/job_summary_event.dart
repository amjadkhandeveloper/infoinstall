// Abstract base class for defining loign-related events

abstract class JobSummaryEvent {}

//Date=2024-03-21&UserID=87
// Event class for triggering the fetching login details valid
class FetchJobSummary extends JobSummaryEvent {
  final String currentDate;
  final int userID;

  FetchJobSummary({required this.currentDate, required this.userID});
}
