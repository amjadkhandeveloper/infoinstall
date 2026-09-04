import 'package:logging/logging.dart';

class JobSummaryDetailsModel {
  final int jobStatusId;
  final String jobStatus;
  final int cnt;

  JobSummaryDetailsModel({
    required this.jobStatusId,
    required this.jobStatus,
    required this.cnt,
  });

  factory JobSummaryDetailsModel.fromJson(Map<String, dynamic> json) {
    Logger(json.toString());
    return JobSummaryDetailsModel(
      jobStatusId: json['JobStatusId'] ?? 0,
      jobStatus: json['JobStatus'] ?? "",
      cnt: json['Cnt'] ?? 0,
    );
  }
}
