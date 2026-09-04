import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

class DashboardData {
  final Image icon;
  final int count;
  final String title;
  final String description;
  final Color? colorCode;

  DashboardData({
    required this.icon,
    required this.count,
    required this.title,
    required this.description,
    required this.colorCode,
  });
}

class DashboardCountDetailsModel {
  final int jobStatusId;
  final String jobStatus;
  final int cnt;

  DashboardCountDetailsModel({
    required this.jobStatusId,
    required this.jobStatus,
    required this.cnt,
  });

  factory DashboardCountDetailsModel.fromJson(Map<String, dynamic> json) {
    Logger(json.toString());
    return DashboardCountDetailsModel(
      jobStatusId: json['JobStatusId'] ?? 0,
      jobStatus: json['JobStatus'] ?? "",
      cnt: json['Cnt'] ?? 0,
    );
  }
}