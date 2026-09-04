// Abstract base class for defining loign-related events

abstract class CheckOutEvent {}

// Event class for triggering the fetching login details valid
class DoCheckOut extends CheckOutEvent {
  final String requestString;
  final int requestType;
  DoCheckOut({required this.requestString, required this.requestType});
}
