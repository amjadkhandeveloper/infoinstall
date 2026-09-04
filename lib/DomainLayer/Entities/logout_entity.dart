import '../../DataLayer/Model/login_model.dart';

class LogoutUser {
  final int status;
  final String message;
  final List<UserData> data;

  LogoutUser({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LogoutUser.fromJson(Map<String, dynamic> json) {
    return LogoutUser(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((userData) => UserData.fromJson(userData))
          .toList(),
    );
  }
}

class LogoutRequest {
  UserLogoutTimeline userLogoutTimeline;
  int insertMode;

  LogoutRequest({
    required this.userLogoutTimeline,
    required this.insertMode,
  });

  factory LogoutRequest.fromJson(Map<String, dynamic> json) {
    return LogoutRequest(
      userLogoutTimeline:
          UserLogoutTimeline.fromJson(json['userLoginTimeline']),
      insertMode: json['insertMode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userLogoutTimeline'] = userLogoutTimeline.toJson();
    data['insertMode'] = insertMode;
    return data;
  }
}

class UserLogoutTimeline {
  int id;
  int userId;
  // String loginTime;
  String logoutTime;
  double loginlat;
  double loginlon;
  double logoutlat;
  double logoutlon;
  double distance;
  String travelTime;
  int batteryStatus;
  String deviceName;
  String deviceModel;
  int cUserId;

  UserLogoutTimeline({
    required this.id,
    required this.userId,
    required this.logoutTime,
    required this.loginlat,
    required this.loginlon,
    required this.logoutlat,
    required this.logoutlon,
    required this.distance,
    required this.travelTime,
    required this.batteryStatus,
    required this.deviceName,
    required this.deviceModel,
    required this.cUserId,
  });

  factory UserLogoutTimeline.fromJson(Map<String, dynamic> json) {
    return UserLogoutTimeline(
      id: json['id'],
      userId: json['userId'],
      logoutTime: json['logoutTime'],
      loginlat: json['loginlat'],
      loginlon: json['loginlon'],
      logoutlat: json['logoutlat'],
      logoutlon: json['logoutlon'],
      distance: json['distance'],
      travelTime: json['travelTime'],
      batteryStatus: json['batteryStatus'],
      deviceName: json['deviceName'],
      deviceModel: json['deviceModel'],
      cUserId: json['cUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['logoutTime'] = logoutTime;
    data['loginlat'] = loginlat;
    data['loginlon'] = loginlon;
    data['logoutlat'] = logoutlat;
    data['logoutlon'] = logoutlon;
    data['distance'] = distance;
    data['travelTime'] = travelTime;
    data['batteryStatus'] = batteryStatus;
    data['deviceName'] = deviceName;
    data['deviceModel'] = deviceModel;
    data['cUserId'] = cUserId;
    return data;
  }
}
