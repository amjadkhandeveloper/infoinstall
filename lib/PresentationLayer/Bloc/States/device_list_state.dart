// Abstract base class for defining DeviceList-related states
import '../../../DataLayer/Model/data_error.dart';
import '../../../DataLayer/Model/device_list_detail_model.dart';

abstract class DeviceListState {}

// Subclass representing the initial state.
class InitialDeviceListState extends DeviceListState {}

// State class indicating that a DeviceList is currently being fetched
class DeviceListLoading extends DeviceListState {}

// State class representing a successfully loaded DeviceList with content, author, tags, and date added
class DeviceListLoaded extends DeviceListState {
  final int? stauts;
  final List<DeviceListDetailsModel> deviceListDetailsModel;
  final List<DataError?> error;

  // Constructor for creating a DeviceListLoaded instance with required data
  DeviceListLoaded({
    required this.stauts,
    required this.deviceListDetailsModel,
    required this.error,
  });
}

// State class representing an error in the DeviceList fetching process with an error message
class DeviceListError extends DeviceListState {
  final String errorMessage;

  // Constructor for creating a DeviceListError instance with the provided error message
  DeviceListError(this.errorMessage);
}
