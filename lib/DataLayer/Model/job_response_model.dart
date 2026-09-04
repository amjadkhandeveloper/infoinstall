// ignore_for_file: non_constant_identifier_names

class JobResponseModelDataJobcnt {
/*
{
  "reccount": 4
} 
*/

  int? reccount;

  JobResponseModelDataJobcnt({
    this.reccount,
  });
  JobResponseModelDataJobcnt.fromJson(Map<String, dynamic> json) {
    reccount = json['reccount']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reccount'] = reccount;
    return data;
  }
}

class JobResponseModelDataJobdet {
/*
{
  "Id": 1,
  "JobId": 9,
  "UserId": 7,
  "CompanyId": 2,
  "JobStatusId": 1,
  "PurposeOfVisitId": 2,
  "ReasonId": 1,
  "ContactName": "shiva",
  "ContactMobileNo": "9999999999",
  "JobLocation": "Galaxy",
  "Lat": 9.9888,
  "Lon": 7.756655,
  "StartTime": "11:30",
  "EndTime": "12:30",
  "StartDate": "2024-01-09T00:00:00.000Z",
  "EndDate": "2024-01-09T00:00:00.000Z",
  "CompletedEndTime": "2024-01-09T14:24:40.193Z",
  "CompanyName": "TCS",
  "JobStatus": "Not Started",
  "PurposeOfVisit": "Meeting",
  "Reason": "Pending",
  "ClientID": 1,
  "StartDateTime": "2024-01-09T11:30:00.000Z",
  "ClientName": "InfoTrack Telematics Pvt LTD"
} 
*/

  int? Id;
  int? JobId;
  int? UserId;
  int? CompanyId;
  int? JobStatusId;
  int? PurposeOfVisitId;
  int? ReasonId;
  String? ContactName;
  String? ContactMobileNo;
  String? JobLocation;
  double? Lat;
  double? Lon;
  String? StartTime;
  String? EndTime;
  String? StartDate;
  String? EndDate;
  String? CompletedEndTime;
  String? CompanyName;
  String? JobStatus;
  String? PurposeOfVisit;
  String? Reason;
  int? ClientID;
  String? StartDateTime;
  String? ClientName;

  JobResponseModelDataJobdet({
    this.Id,
    this.JobId,
    this.UserId,
    this.CompanyId,
    this.JobStatusId,
    this.PurposeOfVisitId,
    this.ReasonId,
    this.ContactName,
    this.ContactMobileNo,
    this.JobLocation,
    this.Lat,
    this.Lon,
    this.StartTime,
    this.EndTime,
    this.StartDate,
    this.EndDate,
    this.CompletedEndTime,
    this.CompanyName,
    this.JobStatus,
    this.PurposeOfVisit,
    this.Reason,
    this.ClientID,
    this.StartDateTime,
    this.ClientName,
  });
  JobResponseModelDataJobdet.fromJson(Map<String, dynamic> json) {
    Id = json['Id']?.toInt();
    JobId = json['JobId']?.toInt();
    UserId = json['UserId']?.toInt();
    CompanyId = json['CompanyId']?.toInt();
    JobStatusId = json['JobStatusId']?.toInt();
    PurposeOfVisitId = json['PurposeOfVisitId']?.toInt();
    ReasonId = json['ReasonId']?.toInt();
    ContactName = json['ContactName']?.toString();
    ContactMobileNo = json['ContactMobileNo']?.toString();
    JobLocation = json['JobLocation']?.toString();
    Lat = json['Lat']?.toDouble();
    Lon = json['Lon']?.toDouble();
    StartTime = json['StartTime']?.toString();
    EndTime = json['EndTime']?.toString();
    StartDate = json['StartDate']?.toString();
    EndDate = json['EndDate']?.toString();
    CompletedEndTime = json['CompletedEndTime']?.toString();
    CompanyName = json['CompanyName']?.toString();
    JobStatus = json['JobStatus']?.toString();
    PurposeOfVisit = json['PurposeOfVisit']?.toString();
    Reason = json['Reason']?.toString();
    ClientID = json['ClientID']?.toInt();
    StartDateTime = json['StartDateTime']?.toString();
    ClientName = json['ClientName']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['JobId'] = JobId;
    data['UserId'] = UserId;
    data['CompanyId'] = CompanyId;
    data['JobStatusId'] = JobStatusId;
    data['PurposeOfVisitId'] = PurposeOfVisitId;
    data['ReasonId'] = ReasonId;
    data['ContactName'] = ContactName;
    data['ContactMobileNo'] = ContactMobileNo;
    data['JobLocation'] = JobLocation;
    data['Lat'] = Lat;
    data['Lon'] = Lon;
    data['StartTime'] = StartTime;
    data['EndTime'] = EndTime;
    data['StartDate'] = StartDate;
    data['EndDate'] = EndDate;
    data['CompletedEndTime'] = CompletedEndTime;
    data['CompanyName'] = CompanyName;
    data['JobStatus'] = JobStatus;
    data['PurposeOfVisit'] = PurposeOfVisit;
    data['Reason'] = Reason;
    data['ClientID'] = ClientID;
    data['StartDateTime'] = StartDateTime;
    data['ClientName'] = ClientName;
    return data;
  }
}

class JobResponseModelData {
/*
{
  "jobdet": [
    {
      "Id": 1,
      "JobId": 9,
      "UserId": 7,
      "CompanyId": 2,
      "JobStatusId": 1,
      "PurposeOfVisitId": 2,
      "ReasonId": 1,
      "ContactName": "shiva",
      "ContactMobileNo": "9999999999",
      "JobLocation": "Galaxy",
      "Lat": 9.9888,
      "Lon": 7.756655,
      "StartTime": "11:30",
      "EndTime": "12:30",
      "StartDate": "2024-01-09T00:00:00.000Z",
      "EndDate": "2024-01-09T00:00:00.000Z",
      "CompletedEndTime": "2024-01-09T14:24:40.193Z",
      "CompanyName": "TCS",
      "JobStatus": "Not Started",
      "PurposeOfVisit": "Meeting",
      "Reason": "Pending",
      "ClientID": 1,
      "StartDateTime": "2024-01-09T11:30:00.000Z",
      "ClientName": "InfoTrack Telematics Pvt LTD"
    }
  ],
  "jobcnt": [
    {
      "reccount": 4
    }
  ]
} 
*/

  List<JobResponseModelDataJobdet?>? jobdet;
  List<JobResponseModelDataJobcnt?>? jobcnt;

  JobResponseModelData({
    this.jobdet,
    this.jobcnt,
  });
  JobResponseModelData.fromJson(Map<String, dynamic> json) {
    if (json['jobdet'] != null) {
      final v = json['jobdet'];
      final arr0 = <JobResponseModelDataJobdet>[];
      v.forEach((v) {
        arr0.add(JobResponseModelDataJobdet.fromJson(v));
      });
      jobdet = arr0;
    }
    if (json['jobcnt'] != null) {
      final v = json['jobcnt'];
      final arr0 = <JobResponseModelDataJobcnt>[];
      v.forEach((v) {
        arr0.add(JobResponseModelDataJobcnt.fromJson(v));
      });
      jobcnt = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (jobdet != null) {
      final v = jobdet;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['jobdet'] = arr0;
    }
    if (jobcnt != null) {
      final v = jobcnt;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['jobcnt'] = arr0;
    }
    return data;
  }
}

class JobResponseModel {
/*
{
  "data": {
    "jobdet": [
      {
        "Id": 1,
        "JobId": 9,
        "UserId": 7,
        "CompanyId": 2,
        "JobStatusId": 1,
        "PurposeOfVisitId": 2,
        "ReasonId": 1,
        "ContactName": "shiva",
        "ContactMobileNo": "9999999999",
        "JobLocation": "Galaxy",
        "Lat": 9.9888,
        "Lon": 7.756655,
        "StartTime": "11:30",
        "EndTime": "12:30",
        "StartDate": "2024-01-09T00:00:00.000Z",
        "EndDate": "2024-01-09T00:00:00.000Z",
        "CompletedEndTime": "2024-01-09T14:24:40.193Z",
        "CompanyName": "TCS",
        "JobStatus": "Not Started",
        "PurposeOfVisit": "Meeting",
        "Reason": "Pending",
        "ClientID": 1,
        "StartDateTime": "2024-01-09T11:30:00.000Z",
        "ClientName": "InfoTrack Telematics Pvt LTD"
      }
    ],
    "jobcnt": [
      {
        "reccount": 4
      }
    ]
  }
} 
*/

  JobResponseModelData? data;

  JobResponseModel({
    this.data,
  });
  JobResponseModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null)
        ? JobResponseModelData.fromJson(json['data'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}
