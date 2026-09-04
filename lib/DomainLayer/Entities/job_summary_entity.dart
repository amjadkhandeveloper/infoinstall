import '../../DataLayer/Model/job_summary_item.dart';

class JobSummaryDetails {
  final int status;
  final String message;
  final List<JobSummaryDetailsModel> datefilterjobcount;
  final List<JobSummaryDetailsModel> todaysjobcount;

  JobSummaryDetails({
    required this.status,
    required this.message,
    required this.datefilterjobcount,
    required this.todaysjobcount,
  });

  factory JobSummaryDetails.fromJson(Map<String, dynamic> json) {
    return JobSummaryDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      datefilterjobcount: (json['datefilterjobcount'] as List)
          .map((datefilterjobcount) =>
              JobSummaryDetailsModel.fromJson(datefilterjobcount))
          .toList(),
      todaysjobcount: (json['todaysjobcount'] as List)
          .map((todaysjobcount) =>
              JobSummaryDetailsModel.fromJson(todaysjobcount))
          .toList(),
    );
  }
}
