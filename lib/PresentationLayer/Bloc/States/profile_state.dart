// Abstract base class for defining login-related states
import 'package:infoinstall/DataLayer/Model/profile_model.dart';

import '../../../DataLayer/Model/data_error.dart';

abstract class ProfileState {}

// Subclass representing the initial state.
class InitialProfileState extends ProfileState {}

// State class indicating that a Profile is currently being fetched
class ProfileLoading extends ProfileState {}

// State class representing a successfully loaded login with content, author, tags, and date added
class ProfileLoaded extends ProfileState {
  final int? stauts;
  final ProfileData profileData;
  final List<DataError?> error;

  // Constructor for creating a ProfileLoaded instance with required data
  ProfileLoaded({
    required this.stauts,
    required this.profileData,
    required this.error,
  });
}

// State class representing an error in the login fetching process with an error message
class ProfileError extends ProfileState {
  final String errorMessage;

  // Constructor for creating a loginError instance with the provided error message
  ProfileError(this.errorMessage);
}
