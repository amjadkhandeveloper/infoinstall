// Abstract base class for defining Installer-related states
import '../../../DataLayer/Model/Installer_details_model.dart';
import '../../../DataLayer/Model/data_error.dart';

abstract class InstallerState {}

// Subclass representing the initial state.
class InitialInstallerState extends InstallerState {}

// State class indicating that a Installer is currently being fetched
class InstallerLoading extends InstallerState {}

// State class representing a successfully loaded Installer with content, author, tags, and date added
class InstallerLoaded extends InstallerState {
  final int? stauts;
  final List<InstallerDetailsModel> installerDetailsModel;
  final List<DataError?> error;

  // Constructor for creating a InstallerLoaded instance with required data
  InstallerLoaded({
    required this.stauts,
    required this.installerDetailsModel,
    required this.error,
  });
}

// State class representing an error in the Installer fetching process with an error message
class InstallerError extends InstallerState {
  final String errorMessage;

  // Constructor for creating a InstallerError instance with the provided error message
  InstallerError(this.errorMessage);
}
