import 'package:infoinstall/DataLayer/Model/login_model.dart';

import '../../DomainLayer/Repository/login_repository.dart';
import '../DataSource/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<void> executeLogin(UserData user) {
    //insertLoginUserData
    return dataSource.executeUserLogin(user);
  }
}
