class JobStatusDetails {
  final int status;
  final String message;

  JobStatusDetails({
    required this.status,
    required this.message,
  });

  factory JobStatusDetails.fromJson(Map<String, dynamic> json) {
    return JobStatusDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
    );
  }
}
