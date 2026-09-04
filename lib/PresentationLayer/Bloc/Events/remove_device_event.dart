// Abstract base class for defining loign-related events

abstract class RemoveDeviceEvent {}

// Event class for triggering the fetching login details valid
class RemoveDevice extends RemoveDeviceEvent {
  final String requestString;
  RemoveDevice({required this.requestString});
}
