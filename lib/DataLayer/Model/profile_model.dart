class ProfileData {
  final String employeeName;
  final String userName;
  final String emailId;
  final String mobileno;
  final String address;
  final String roleName;

  ProfileData({
    required this.employeeName,
    required this.userName,
    required this.emailId,
    required this.mobileno,
    required this.address,
    required this.roleName,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      employeeName: json['EmployeeName'],
      userName: json['UserName'],
      emailId: json['EmailId'],
      mobileno: json['Mobileno'],
      address: json['Address'],
      roleName: json['RoleName'],
    );
  }
}
