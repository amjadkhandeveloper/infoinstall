import 'package:infoinstall/DataLayer/Model/client_details_model.dart';

class ClientDetails {
  final int status;
  final String message;
  final List<ClientDetailsModel> data;

  ClientDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: (json['data'] as List)
          .map((userData) => ClientDetailsModel.fromJson(userData))
          .toList(),
    );
  }
}
