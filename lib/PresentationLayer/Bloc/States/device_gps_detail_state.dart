// Abstract base class for defining DeviceGpsDetail-related states
import 'package:infoinstall/DataLayer/Model/device_gps_detail_model.dart';

import '../../../DataLayer/Model/data_error.dart';

abstract class DeviceGpsDetailState {}

// Subclass representing the initial state.
class InitialDeviceGpsDetailState extends DeviceGpsDetailState {}

// State class indicating that a DeviceGpsDetail is currently being fetched
class DeviceGpsDetailLoading extends DeviceGpsDetailState {}

// State class representing a successfully loaded DeviceGpsDetail with content, author, tags, and date added
class DeviceGpsDetailLoaded extends DeviceGpsDetailState {
  final int? stauts;
  final List<DeviceGpsDetailModel> deviceGpsDetailModel;
  final List<DataError?> error;

  // Constructor for creating a DeviceGpsDetailLoaded instance with required data
  DeviceGpsDetailLoaded({
    required this.stauts,
    required this.deviceGpsDetailModel,
    required this.error,
  });
}

// State class representing an error in the DeviceGpsDetail fetching process with an error message
class DeviceGpsDetailError extends DeviceGpsDetailState {
  final String errorMessage;

  // Constructor for creating a DeviceGpsDetailError instance with the provided error message
  DeviceGpsDetailError(this.errorMessage);
}
