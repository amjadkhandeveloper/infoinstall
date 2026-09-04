// Abstract base class for defining loign-related events
import 'package:infoinstall/DomainLayer/Entities/logout_entity.dart';

import '../../../DomainLayer/Entities/login_entity.dart';

abstract class LoginEvent {}

// Event class for triggering the fetching login details valid
class FetchLogin extends LoginEvent {
  LoginRequest loginRequest;

  FetchLogin({required this.loginRequest});
}

// Event class for triggering the fetching login details valid
class DoLogout extends LoginEvent {
  LogoutRequest logoutRequest;

  DoLogout({required this.logoutRequest});
}

// Event class for triggering the fetching login details valid
class ResetLogin extends LoginEvent {}
