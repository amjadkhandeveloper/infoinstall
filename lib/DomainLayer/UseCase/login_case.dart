import 'package:infoinstall/DataLayer/Model/login_model.dart';

import '../Repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<void> executeLogin(UserData user) {
    return repository.executeLogin(user);
  }
}
