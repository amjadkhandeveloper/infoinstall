// Abstract base class for defining loign-related events
abstract class DeviceListEvent {}

// Event class for triggering the fetching login details valid
class FetchDeviceList extends DeviceListEvent {
  final String jobID;
  final String userID;
  FetchDeviceList({required this.jobID, required this.userID});
}
