import 'package:infoinstall/DataLayer/Model/device_gps_detail_model.dart';

class DeviceGpsDetailEntity {
  final int status;
  final String message;
  final List<DeviceGpsDetailModel> data;

  DeviceGpsDetailEntity(
      {required this.status, required this.message, required this.data, x});

  factory DeviceGpsDetailEntity.fromJson(Map<String, dynamic> json) {
    return DeviceGpsDetailEntity(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: (json['data'] as List)
          .map((userData) => DeviceGpsDetailModel.fromJson(userData))
          .toList(),
    );
  }
}
