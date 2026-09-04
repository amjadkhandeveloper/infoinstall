class InstallerDetailsModel {
  final int installerID;
  final String employeeName;
  final String mobileNO;
  final String emailID;
  final String address;
  final String roleName;

  InstallerDetailsModel({
    required this.installerID,
    required this.employeeName,
    required this.mobileNO,
    required this.emailID,
    required this.address,
    required this.roleName,
  });

  factory InstallerDetailsModel.fromJson(Map<String, dynamic> json) {
    return InstallerDetailsModel(
      installerID: json['ID'] ?? 0,
      employeeName: (json['FirstName'] ?? '') + ' ' + (json['LastName'] ?? ''),
      mobileNO: json['MobileNo'] ?? '',
      emailID: json['emailID'] ?? '',
      address: json['Address'] ?? '',
      roleName: json['RoleName'] ?? '',
    );
  }
}
