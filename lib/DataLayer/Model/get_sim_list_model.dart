class SimData {
  final String SIMType;
  final int SIMID;
  final String MobileNo;

  SimData({required this.SIMType, required this.SIMID, required this.MobileNo});

  factory SimData.fromJson(Map<String, dynamic> json) {
    return SimData(
      SIMType: json['SIMType'],
      SIMID: json['SIMID'],
      MobileNo: json['MobileNo'],
    );
  }
}
