// Abstract base class for defining Client-related states
import '../../../DataLayer/Model/client_details_model.dart';
import '../../../DataLayer/Model/data_error.dart';

abstract class ClientState {}

// Subclass representing the initial state.
class InitialClientState extends ClientState {}

// State class indicating that a Client is currently being fetched
class ClientLoading extends ClientState {}

// State class representing a successfully loaded Client with content, author, tags, and date added
class ClientLoaded extends ClientState {
  final int? stauts;
  final List<ClientDetailsModel> clientDetailsModel;
  final List<DataError?> error;

  // Constructor for creating a ClientLoaded instance with required data
  ClientLoaded({
    required this.stauts,
    required this.clientDetailsModel,
    required this.error,
  });
}

// State class representing an error in the Client fetching process with an error message
class ClientError extends ClientState {
  final String errorMessage;

  // Constructor for creating a ClientError instance with the provided error message
  ClientError(this.errorMessage);
}
