// Abstract base class for defining loign-related events
abstract class DeviceGpsDetailEvent {}

// Event class for triggering the fetching login details valid
class FetchDeviceGpsDetail extends DeviceGpsDetailEvent {
  final String unitno;
  final String simNo;

  FetchDeviceGpsDetail({required this.unitno, required this.simNo});
}
