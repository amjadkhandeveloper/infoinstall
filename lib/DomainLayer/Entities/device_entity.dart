import '../../DataLayer/Model/device_list_detail_model.dart';

class DeviceListDetails {
  final int status;
  final String message;
  final List<DeviceListDetailsModel> data;

  DeviceListDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeviceListDetails.fromJson(Map<String, dynamic> json) {
    return DeviceListDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: (json['data'] as List)
          .map((userData) => DeviceListDetailsModel.fromJson(userData))
          .toList(),
    );
  }
}
