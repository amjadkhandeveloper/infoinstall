class DeviceListDetailsModel {
  int? jobId;
  int? userId;
  String? employeename;
  int? clientId;
  String? clientName;
  int? vehicleId;
  String? vehicleNo;
  int? unitId;
  String? unitNo;
  String? mobileNo;
  int? statusId;
  String? jobstatus;
  String? installationDate;
  bool? isActive;
  int? iSInstalled;

  DeviceListDetailsModel({
    this.jobId,
    this.userId,
    this.employeename,
    this.clientId,
    this.clientName,
    this.vehicleId,
    this.vehicleNo,
    this.unitId,
    this.unitNo,
    this.mobileNo,
    this.statusId,
    this.jobstatus,
    this.installationDate,
    this.isActive,
    this.iSInstalled,
  });

  Map<String, dynamic> toMap() {
    return {
      'JobId': jobId,
      'UserId': userId,
      'Employeename': employeename,
      'ClientId': clientId,
      'ClientName': clientName,
      'VehicleId': vehicleId,
      'VehicleNo': vehicleNo,
      'unitId': unitId,
      'UnitNo': unitNo,
      'MobileNo': mobileNo,
      'StatusId': statusId,
      'Jobstatus': jobstatus,
      'InstallationDate': installationDate,
      'IsActive': isActive,
      'ISInstalled': iSInstalled,
    };
  }

  factory DeviceListDetailsModel.fromJson(Map<String, dynamic> json) {
    return DeviceListDetailsModel(
      jobId: json['JobId'] as int?,
      userId: json['UserId'] as int?,
      employeename: json['Employeename'] as String?,
      clientId: json['ClientId'] as int?,
      clientName: json['ClientName'] as String?,
      vehicleId: json['VehicleId'] as int,
      vehicleNo: json['VehicleNo'] as String?,
      unitId: json['unitId'] as int,
      unitNo: json['UnitNo'] as String,
      mobileNo: json['MobileNo'] as String,
      statusId: json['StatusId'] as int,
      jobstatus: json['Jobstatus'] as String,
      installationDate: json['InstallationDate'] as String?,
      isActive: json['IsActive'] as bool,
      iSInstalled: json['ISInstalled'] as int,
    );
  }
}
