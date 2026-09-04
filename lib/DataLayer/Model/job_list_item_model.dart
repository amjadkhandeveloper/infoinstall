import 'package:infoinstall/PresentationLayer/Components/common_extension.dart';

import 'device_list_detail_model.dart';

class JobListDetailsModel {
  int? jobId;
  int? userId;
  String? employeename;
  String? clientName;
  int? jobStatusId;
  int? purposeOfVisitId;
  int? reasonId;
  String? jobLocation;
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  String? jobStatus;
  String? purposeOfVisit;
  String? reason;
  String? startDateTime;
  String? endDateTime;
  List<DeviceListDetailsModel>? deviceList;

  JobListDetailsModel({
    this.jobId,
    this.userId,
    this.employeename,
    this.clientName,
    this.jobStatusId,
    this.purposeOfVisitId,
    this.reasonId,
    this.jobLocation,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.jobStatus,
    this.purposeOfVisit,
    this.reason,
    this.startDateTime,
    this.endDateTime,
    this.deviceList,
  });

  factory JobListDetailsModel.fromJson(Map<String, dynamic> json) {
    return JobListDetailsModel(
      jobId: json['JobId'],
      userId: json['UserId'],
      employeename: json['Employeename'],
      clientName: json['ClientName'],
      jobStatusId: json['JobStatusId'],
      purposeOfVisitId: json['PurposeOfVisitId'],
      reasonId: json['ReasonId'],
      jobLocation: json['JobLocation'],
      startTime: json['StartTime'],
      endTime: json.parseToString('EndTime') == ''
          ? '23:59:00'
          : json.parseToString('EndTime'), // ['EndTime'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
      jobStatus: json['JobStatus'],
      purposeOfVisit: json['PurposeOfVisit'],
      reason: json['Reason'],
      startDateTime: json['StartDateTime'],
      endDateTime: json['EndDateTime'],
      deviceList: [],
    );
  }
}
