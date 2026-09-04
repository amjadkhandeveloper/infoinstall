import 'package:logging/logging.dart';

class ClientDetailsModel {
  final int clientID;
  final String clientName;
  final String mobileNO;
  final String emailID;
  final String address;
  final int jobCount;

  ClientDetailsModel({
    required this.clientID,
    required this.clientName,
    required this.mobileNO,
    required this.emailID,
    required this.address,
    required this.jobCount,
  });

  factory ClientDetailsModel.fromJson(Map<String, dynamic> json) {
    Logger(json.toString());
    return ClientDetailsModel(
      clientID: json['ClientID'] ?? 0,
      clientName: json['ClientName'] ?? '',
      mobileNO: json['MobileNO'] ?? '',
      emailID: json['emailID'] ?? '',
      address: json['Address'] ?? '',
      jobCount: json['JobCount'] ?? 0,
    );
  }
}
