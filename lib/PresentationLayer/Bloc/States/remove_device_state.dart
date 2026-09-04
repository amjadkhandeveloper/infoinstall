// Abstract base class for defining RemoveDevice-related states
import '../../../DataLayer/Model/data_error.dart';

abstract class RemoveDeviceState {}

// Subclass representing the initial state.
class InitialRemoveDeviceState extends RemoveDeviceState {}

// State class indicating that a RemoveDevice is currently being fetched
class RemoveDeviceLoading extends RemoveDeviceState {}

// State class representing a successfully loaded RemoveDevice with content, author, tags, and date added
class RemoveDeviceLoaded extends RemoveDeviceState {
  final int? stauts;
  final String? message;
  final List<DataError?> error;

  // Constructor for creating a RemoveDeviceLoaded instance with required data
  RemoveDeviceLoaded({
    required this.stauts,
    required this.message,
    required this.error,
  });
}

// State class representing an error in the RemoveDevice fetching process with an error message
class RemoveDeviceError extends RemoveDeviceState {
  final String errorMessage;

  // Constructor for creating a RemoveDeviceError instance with the provided error message
  RemoveDeviceError(this.errorMessage);
}
