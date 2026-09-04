import 'package:infoinstall/DataLayer/Model/timeline_data_model.dart';

import '../../DataLayer/Model/login_model.dart';

class LogoutUser {
  final int status;
  final String message;
  LogoutUser({
    required this.status,
    required this.message,
  });
  factory LogoutUser.fromJson(Map<String, dynamic> json) {
    return LogoutUser(
      status: json['status'],
      message: json['message'],
    );
  }
}

class LoginErrorUser {
  final int status;
  final String message;
  LoginErrorUser({
    required this.status,
    required this.message,
  });

  factory LoginErrorUser.fromJson(Map<String, dynamic> json) {
    return LoginErrorUser(
      status: json['status'],
      message: json['message'],
    );
  }
}

class LoginUser {
  final int status;
  final String message;
  final List<UserData> data;
  final List<TimeLineData> timeLineData;

  LoginUser({
    required this.status,
    required this.message,
    required this.data,
    required this.timeLineData,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((userData) => UserData.fromJson(userData))
          .toList(),
      timeLineData: (json['timelinedata'] as List)
          .map((timelinedata) => TimeLineData.fromJson(timelinedata))
          .toList(),
    );
  }
}

class LoginRequest {
  String loginName;
  String loginPassword;
  UserLoginTimeline userLoginTimeline;
  int insertMode;

  LoginRequest({
    required this.loginName,
    required this.loginPassword,
    required this.userLoginTimeline,
    required this.insertMode,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      loginName: json['loginName'],
      loginPassword: json['loginPassword'],
      userLoginTimeline: UserLoginTimeline.fromJson(json['userLoginTimeline']),
      insertMode: json['insertMode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginName'] = loginName;
    data['loginPassword'] = loginPassword;
    data['userLoginTimeline'] = userLoginTimeline.toJson();
    data['insertMode'] = insertMode;
    return data;
  }
}

class UserLoginTimeline {
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

  UserLoginTimeline({
    required this.id,
    required this.userId,
    // required this.loginTime,
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

  factory UserLoginTimeline.fromJson(Map<String, dynamic> json) {
    return UserLoginTimeline(
      id: json['id'],
      userId: json['userId'],
      // loginTime: json['loginTime'],
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
    // data['loginTime'] = loginTime;
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
