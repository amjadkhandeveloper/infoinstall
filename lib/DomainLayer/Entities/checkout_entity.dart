class CheckOutDetails {
  final int status;
  final String message;

  CheckOutDetails({
    required this.status,
    required this.message,
  });

  factory CheckOutDetails.fromJson(Map<String, dynamic> json) {
    return CheckOutDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
    );
  }
}
