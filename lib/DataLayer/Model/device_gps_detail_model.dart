import 'package:infoinstall/PresentationLayer/Components/constant.dart';

class DeviceGpsDetailModel {
  String? vehicleNo;
  String? unitNo;
  String? simNo;
  String? tracktime;
  double? lat;
  double? lon;
  String? location;
  int? ignition;
  int? speed;
  int? gpsstatus;
  int? immobalizer;
  int? panic;
  int? mainpower;
  int? batteryLevel;
  String? applications;

  DeviceGpsDetailModel({
    this.vehicleNo,
    this.unitNo,
    this.simNo,
    this.tracktime,
    this.lat,
    this.lon,
    this.location,
    this.ignition,
    this.speed,
    this.gpsstatus,
    this.immobalizer,
    this.panic,
    this.mainpower,
    this.batteryLevel,
    this.applications,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleNo': vehicleNo,
      'unitNo': unitNo,
      'SimNo': simNo,
      'tracktime': tracktime,
      'lat': lat,
      'lon': lon,
      'location': location,
      'ignition': ignition,
      'speed': speed,
      'gpsstatus': gpsstatus,
      'immobalizer': immobalizer,
      'panic': panic,
      'mainpower': mainpower,
      'BatteryLevel': batteryLevel,
      'applications': applications,
    };
  }

  factory DeviceGpsDetailModel.fromJson(Map<String, dynamic> json) {
    return DeviceGpsDetailModel(
      vehicleNo: json.parseToString('vehicleNo'), //as String?,
      unitNo: json.parseToString('unitNo'), // as String?,
      simNo: json.parseToString('SimNo'), // as String?,
      tracktime: json.parseToString('tracktime'), // as String?,
      lat: json.parseToDouble('lat'), // as double?,
      lon: json.parseToDouble('lon'), // as double?,
      location: json.parseToString('location'), // as String?,
      ignition: json.parseToInt('ignition'), // as int,
      speed: json.parseToInt('speed'), // as int,
      gpsstatus: json.parseToInt('gpsstatus'), //as int,
      immobalizer: json.parseToInt('immobalizer'), //as int,
      panic: json.parseToInt('panic'), //as int,
      mainpower: json.parseToInt('mainpower'), // as int,
      batteryLevel: json.parseToInt('BatteryLevel'), // as int,
      applications: json.parseToString('applications'), // as String,
    );
  }
}
