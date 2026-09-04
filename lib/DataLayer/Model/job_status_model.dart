import 'dart:convert';

class JobStatusUpdate {
  int jobId;
  int userId;
  int jobStatusId;
  int purposeOfVisitId;
  DateTime statusDate = DateTime(2024, 09, 12, 12, 30, 00);
  double lat;
  double lon;
  int simId;
  int unitId;
  String remarks;

  JobStatusUpdate(
    this.jobId,
    this.userId,
    this.jobStatusId,
    this.purposeOfVisitId,
    this.lat,
    this.lon,
    this.simId,
    this.unitId,
    this.remarks,
  );

  // Method to convert object to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'userId': userId,
      'jobStatusId': jobStatusId,
      'purposeofvisitId': purposeOfVisitId,
      'statusDate': statusDate.toIso8601String(),
      'lat': lat,
      'lon': lon,
      'simId': simId,
      'unitId': unitId,
      'remarks': remarks,
    };
  }
}
