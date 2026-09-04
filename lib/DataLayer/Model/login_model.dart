import 'package:infoinstall/PresentationLayer/Components/common_extension.dart';

class UserData {
  final int resultID;
  final String resultMessage;
  final int userID;
  final int roleID;
  final String userName;
  final String roleName;
  final String? firstName; // Make it nullable
  // final double? lat; // Nullable for optional lat/lon
  // final double? lon;

  UserData({
    required this.resultID,
    required this.resultMessage,
    required this.userID,
    required this.roleID,
    required this.userName,
    required this.roleName,
    required this.firstName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      resultID: json.parseToInt('ResultID'), //json['ResultID'],
      resultMessage:
          json.parseToString('ResultMessage'), //json['ResultMessage'],
      userID: json.parseToInt('Userid'), //json['Userid'],
      roleID: json.parseToInt('RoleId'), //json['RoleId'],
      userName: json.parseToString('UserName'), // json['UserName'],
      roleName: json.parseToString('RoleName'), // json['RoleName'],
      firstName: json.parseToString('FirstName'), // json['FirstName'],
    );
  }
}
