import 'package:flutter/material.dart';

import '../../DataLayer/Model/onboard_model.dart';

const versionCode = '1.1.2';

// const infoInstallProductionURL = "http://180.179.236.125:8008/api/";

// const infoInstallProductionURL =
//     "https://infoinstallapipoc.infotracktelematics.com/api/";

const infoInstallProductionURL =
    "https://infoinstallapi.infotracktelematics.com/api/";

//Profile Screen
const profileUrlApi = "Employee/GetEmployeeProfile?Userid=";

//Login Screen
const loginUrlApi = "Login/EmployeeLogin";

//Logout Screen
const logoutUrlApi = "Login/EmployeeLogout";

//Clint list screen 0 for all
const clientListApi = "Client/ClientList?ClientID=";

//Dashboard screen
const dashbaordApi = "MobileDashboard/DashboardJobCount?Date=";
const dahboardUserId = "&UserID=";

//installer list 0 for all
const installerListApi = "Employee/ListofEmployee?EmployeeID=";

//installer list
const profileApi = "Employee/ListofEmployee?EmployeeID=";

//device list
const deviceListApi = "Job/Jobunitlist?JobId=";

//delete device from job
const jobDeviceDelete = "Job/DeleteJobUnit";

//device list
const deviceGpsDetailApi = "MobileDashboard/GpsDataForUnit?Unitno=";

//Dashboard screen
//http://180.179.236.125:8008/api/MobileDashboard/DashboardJobCountDetails?Date=2024-03-21&UserID=87&JobStatusId=1
const jobListApi = "MobileDashboard/DashboardJobCountDetails?Date=";
const jobUserIdApi = "&UserID=";
const jobStatusApi = "&JobStatusId=";

const spareSimList = "Sim/GetSpareSIMLists?AgentID=7";

const jobUnitImageUpdate = "MobileJobUnitUpdate/UpdateJobUnitImage";
const jobDeviceUpdate = "MobileJobUnitUpdate/JobUnitUpdate";
const jobStatusUpdate = "MobileJobUnitUpdate/UpdateEmployeeActivity";

const kAnimationDuration = Duration(milliseconds: 200);

final List<AllinOnboardModel> allinonboardlist = [
  AllinOnboardModel(
      "assets/images/intro_1.jpg",
      "Choose the installer to whom you would like to assign the task of installation.",
      "Select Installer"),
  AllinOnboardModel(
      "assets/images/intro_2.jpg",
      "Install the tracking device in the vehicle for vehicle monitoring.",
      "Install Device"),
  AllinOnboardModel(
      "assets/images/intro_3.jpg",
      "Now track the vehicle post-installation and receive the latest alerts.",
      "Track Vehicle"),
];

//Storage and Database related keys

//* Hive Box
const String hiveBox1 = "infoinstall_v1";

//*Hive Keys
const String kUSERID = "kUSERID";
const String kID = "ID";
const String isLogin = "ISLOGIN";

int getJobStatusId(String status) {
  // Mapping job descriptions to their corresponding IDs
  Map<String, int> jobStatusMap = {
    "Not Started": 1,
    "Accepted": 2,
    "Enroute": 3,
    "Reschedule": 4,
    "Check IN": 5,
    "Check OUT": 6,
    "Completed": 7,
    "Declined": 8,
    "Installation Completed": 9,
    "Vehicle Created": 10
  };

  // Return the corresponding JobStatusId, or -1 if not found
  return jobStatusMap[status] ?? 2;
}

// 8 installation
// 5 remove
// 6 replace

String getCapsStatus(String statusCode) {
  switch (statusCode) {
    case '1':
      return 'NOT STARTED';
    case '2':
      return 'ACCEPTED';
    case '3':
      return 'ENROUTE';
    case '4':
      return 'RESCHEDULED';
    case '5':
      return 'CHECKED-IN';
    case '6':
      return 'CHECKED-OUT';
    case '7':
      return 'COMPLETED';
    case '8':
      return 'DECLINED';
    case '9':
      return 'JOB COMPLETED';
    case '10':
      return 'VEHICLE CREATED';
    default:
      return 'UNKNOWN';
  }
}

String getStatus(String statusCode) {
  switch (statusCode) {
    case '1':
      return 'Not Started';
    case '2':
      return 'Accepted';
    case '3':
      return 'Enroute';
    case '4':
      return 'Reschedule';
    case '5':
      return 'Check IN';
    case '6':
      return 'Check OUT';
    case '7':
      return 'Completed';
    case '8':
      return 'Declined';
    case '9':
      return 'Job Completed';
    case '10':
      return 'Vehicle Created';
    default:
      return 'Unknown Status';
  }
}

String getAdvanceStatus(String statusCode) {
  switch (statusCode) {
    case '1':
      return 'ACCEPT';
    case '2':
      return 'ENROUTE';
    case '4':
      return 'ACCEPT'; //RESCHEDULE Changed to ACCEPT as per Sharan
    case '3':
      return 'CHECK-IN';
    case '5':
      return 'CHECK-OUT';
    case '6':
      return 'COMPLETE';
    case '8':
      return 'DECLINE';
    case '7':
      return 'JOB COMPLETE';
    case '10':
      return 'VEHICLE CREATED';
    default:
      return 'UNKNOWN';
  }
}

Color? getAdvanceColorStatus(String statusCode) {
  switch (statusCode) {
    case '1':
      return Colors.amber[700];
    case '2':
      return Colors.deepOrange[600];
    case '4':
      return Colors.cyan[700];
    case '3':
      return Colors.yellow[800];
    case '5':
      return Colors.blue[700];
    case '6':
      return Colors.green[700];
    case '8':
      return Colors.red[700];
    case '7':
      return Colors.green[900];
    case '10':
      return Colors.grey[700];
    default:
      return Colors.blueGrey[700];
  }
}

extension FirstOrNullExtension<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}

extension JsonObjectItemExtension on Map<String, dynamic> {
  String parseToString(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToString(data);
    }
    return 'NA';
  }

  String _parseDataToString(dynamic data) {
    if (data is String) {
      return data;
    } else if (data is int || data is double) {
      return data.toString();
    } else if (data is bool) {
      return data.toString();
    } else if (data is List) {
      return "N/A";
    } else if (data is Map) {
      return "N/A";
    }
    return 'NA';
  }

  String parseToDateString(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDateToString(data);
    }
    return 'NA';
  }

  String _parseDateToString(dynamic data) {
    String dateFormate = _parseDataToString(data).replaceAll("T", " ");
    return dateFormate;
  }

  int parseToInt(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToInt(data);
    }
    return -1;
  }

  int _parseDataToInt(dynamic data) {
    if (data is int) {
      return data;
    } else if (data is double) {
      return data.toInt();
    } else if (data is bool) {
      return data ? 1 : 0;
    } else if (data is List) {
      return 0;
    } else if (data is Map) {
      return 0;
    }
    return 0;
  }

  double parseToDouble(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToDouble(data);
    }
    return -1.0;
  }

  double _parseDataToDouble(dynamic data) {
    if (data is double) {
      return data;
    } else if (data is int) {
      return data.toDouble();
    } else if (data is bool) {
      return data ? 1.0 : 0.0;
    } else if (data is List) {
      return 0.0;
    } else if (data is Map) {
      return 0.0;
    }
    return 0.0;
  }

  List<dynamic> parseToList(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToList(data);
    }
    return [];
  }

  List<dynamic> _parseDataToList(dynamic data) {
    if (data is List) {
      return data;
    } else if (data is int) {
      return [];
    } else if (data is double) {
      return [];
    } else if (data is bool) {
      return data ? [] : [];
    } else if (data is Map) {
      return [];
    }
    return [];
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension DateTimeFormatting on String {
  String toFormattedDateTime() {
    try {
      DateTime dateTime = DateTime.parse(this);
      String formattedDate =
          "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
      String formattedTime =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
      return "$formattedDate $formattedTime";
    } catch (e) {
      return "01-01-2024 00:00:00.000";
    }
  }
}
