import 'package:infoinstall/DataLayer/Model/login_model.dart';

abstract class LoginRepository {
  // Future<List<DashboardData>> fetchDashbaordContent();

  Future<void> executeLogin(UserData user);
}
