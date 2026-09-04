import '../../DataLayer/Model/job_list_item_model.dart';

class JobListDetails {
  final int status;
  final String message;
  final List<JobListDetailsModel> data;

  JobListDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory JobListDetails.fromJson(Map<String, dynamic> json) {
    return JobListDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: (json['data'] as List)
          .map((jobListDetails) => JobListDetailsModel.fromJson(jobListDetails))
          .toList(),
    );
  }
}
