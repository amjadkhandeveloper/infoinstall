class RemoveDeviceDetails {
  final int status;
  final String message;

  RemoveDeviceDetails({
    required this.status,
    required this.message,
  });

  factory RemoveDeviceDetails.fromJson(Map<String, dynamic> json) {
    return RemoveDeviceDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
    );
  }
}
