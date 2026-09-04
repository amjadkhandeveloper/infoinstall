import 'package:infoinstall/DataLayer/Model/Installer_details_model.dart';

class InstallerDetails {
  final int status;
  final String message;
  final List<InstallerDetailsModel> data;

  InstallerDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InstallerDetails.fromJson(Map<String, dynamic> json) {
    return InstallerDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: (json['data'] as List)
          .map((userData) => InstallerDetailsModel.fromJson(userData))
          .toList(),
    );
  }
}
