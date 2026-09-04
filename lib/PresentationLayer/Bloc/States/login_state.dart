// Abstract base class for defining login-related states

import '../../../DataLayer/Model/data_error.dart';
import '../../../DomainLayer/Entities/login_entity.dart';

abstract class LoginState {}

// Subclass representing the initial state.
class InitialLoginState extends LoginState {}

// State class indicating that a Login is currently being fetched
class LoginLoading extends LoginState {}

// State class representing a successfully loaded login with content, author, tags, and date added
class LoginLoaded extends LoginState {
  final int? status;
  final LoginUser user;
  final List<DataError?> error;

  // Constructor for creating a LoginLoaded instance with required data
  LoginLoaded({
    required this.status,
    required this.user,
    required this.error,
  });
}

// State class representing a successfully loaded login with content, author, tags, and date added
class LogoutLoaded extends LoginState {
  final int? status;
  final String? message;
  // Constructor for creating a LoginLoaded instance with required data
  LogoutLoaded({
    required this.status,
    required this.message,
  });
}

// State class representing an error in the login fetching process with an error message
class LoginError extends LoginState {
  final String errorMessage;

  // Constructor for creating a loginError instance with the provided error message
  LoginError(this.errorMessage);
}
