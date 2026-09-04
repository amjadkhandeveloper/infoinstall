// Abstract base class for defining CheckOut-related states
import '../../../DataLayer/Model/data_error.dart';

abstract class CheckOutState {}

// Subclass representing the initial state.
class InitialCheckOutState extends CheckOutState {}

// State class indicating that a CheckOut is currently being fetched
class CheckOutLoading extends CheckOutState {}

// State class representing a successfully loaded CheckOut with content, author, tags, and date added
class CheckOutLoaded extends CheckOutState {
  final int? stauts;
  final String? message;
  final List<DataError?> error;

  // Constructor for creating a CheckOutLoaded instance with required data
  CheckOutLoaded({
    required this.stauts,
    required this.message,
    required this.error,
  });
}

class CheckOutImageUploaded extends CheckOutState {
  final int? stauts;
  final String? message;
  final List<DataError?> error;

  // Constructor for creating a CheckOutLoaded instance with required data
  CheckOutImageUploaded({
    required this.stauts,
    required this.message,
    required this.error,
  });
}

// State class representing an error in the CheckOut fetching process with an error message
class CheckOutError extends CheckOutState {
  final String errorMessage;

  // Constructor for creating a CheckOutError instance with the provided error message
  CheckOutError(this.errorMessage);
}
