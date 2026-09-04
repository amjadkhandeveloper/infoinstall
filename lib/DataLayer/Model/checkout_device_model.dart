import 'dart:convert';

import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';

class JobInstallationData with PrintMixin {
  int installerId = 0;
  int clientId = 0;
  int vehicleId = 0;
  int unitId = 0;
  int statusId = 0;
  DateTime installationDate = DateTime(2024, 04, 03, 12, 00, 00);
  int isActive = 0;
  int createdUserId = 0;
  int modifiedUserId = 0;
  int agentId = 0;
  String image1 = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";
  String image5 = "";
  String image6 = "";
  String signatureImage = "";
  String vehicleno = "";
  String simNo = "";
  String newSimNo = "";
  String remarks = "";
  DateTime acceptedDateTime = DateTime(2024, 04, 03, 12, 00, 00);
  DateTime checkinDateTime = DateTime(2024, 04, 03, 12, 00, 00);
  DateTime checkoutDateTime = DateTime(2024, 04, 03, 12, 00, 00);
  DateTime completedDateTime = DateTime(2024, 04, 03, 12, 00, 00);
  DateTime enrouteDateTime = DateTime(2024, 04, 03, 12, 00, 00);
  DateTime declinedDateTime = DateTime(2024, 04, 03, 12, 00, 00);
  int oldunit = 0;
  int jobid = 0;
  int insertMode = 1;

  JobInstallationData();

  // Constructor
  // const JobInstallationData({
  //   required this.installerId,
  //   required this.clientId,
  //   required this.vehicleId,
  //   required this.unitId,
  //   required this.statusId,
  //   required this.installationDate,
  //   required this.isActive,
  //   required this.createdUserId,
  //   required this.modifiedUserId,
  //   required this.agentId,
  //   required this.image1,
  //   required this.image2,
  //   required this.image3,
  //   required this.image4,
  //   required this.image5,
  //   required this.image6,
  //   required this.signatureImage,
  //   required this.vehicleno,
  //   required this.simNo,
  //   required this.remarks,
  //   required this.acceptedDateTime,
  //   required this.checkinDateTime,
  //   required this.checkoutDateTime,
  //   required this.completedDateTime,
  //   required this.enrouteDateTime,
  //   required this.declinedDateTime,
  //   required this.jobid,
  //   required this.insertMode,
  // });

  // Method to convert object to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    p('installerId: $installerId clientId: $clientId vehicleId: $vehicleId');
    p('unitId: $unitId statusId: $statusId createdUserId: $createdUserId');
    p('modifiedUserId: $modifiedUserId vehicleno: $vehicleno statusId: $simNo NewSimNo $newSimNo');
    p('installationDate: ${installationDate.toIso8601String()}');
    p('image1 $image1');
    p('oldunit: $oldunit jobid: $jobid');
    return {
      'jobInstallationDataVO': {
        'installerId': installerId,
        'clientId': clientId,
        'vehicleId': vehicleId,
        'unitId': unitId,
        'statusId': statusId,
        'installationDate': installationDate.toIso8601String(),
        'isActive': isActive,
        'createdUserId': createdUserId,
        'modifiedUserId': modifiedUserId,
        'agentId': agentId,
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'image4': image4,
        'image5': image5,
        'image6': image6,
        'signatureImage': signatureImage,
        'vehicleno': vehicleno,
        'simNo': simNo,
        'NewSimNo': newSimNo,
        'remarks': remarks,
        'acceptedDateTime': acceptedDateTime.toIso8601String(),
        'checkinDateTime': checkinDateTime.toIso8601String(),
        'checkoutDateTime': checkoutDateTime.toIso8601String(),
        'completedDateTime': completedDateTime.toIso8601String(),
        'enrouteDateTime': enrouteDateTime.toIso8601String(),
        'declinedDateTime': declinedDateTime.toIso8601String(),
        'oldunit': oldunit
      },
      'jobid': jobid,
      'insertMode': insertMode,
    };
  }

  // Build minimal payload for JobUnitUpdate as per Swagger working example
  String toJsonStringMinimalForJobUnitUpdate() {
    return jsonEncode(toJsonMinimalForJobUnitUpdate());
  }

  Map<String, dynamic> toJsonMinimalForJobUnitUpdate() {
    return {
      'jobInstallationDataVO': {
        'installerId': installerId,
        'clientId': clientId,
        'vehicleId': vehicleId,
        'unitId': unitId,
        'statusId': statusId,
        'installationDate': installationDate.toIso8601String(),
        'isActive': isActive,
        'createdUserId': createdUserId,
        'modifiedUserId': modifiedUserId,
        'agentId': agentId,
        // Only image1 as per curl sample
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'image4': image4,
        'image5': image5,
        'image6': image6,
        'signatureImage': signatureImage,
        'vehicleno': vehicleno,
        'simNo': simNo,
        // 'NewSimNo': newSimNo,
        'remarks': remarks,
        'acceptedDateTime': acceptedDateTime.toIso8601String(),
        'checkinDateTime': checkinDateTime.toIso8601String(),
        'checkoutDateTime': checkoutDateTime.toIso8601String(),
        'completedDateTime': completedDateTime.toIso8601String(),
        'enrouteDateTime': enrouteDateTime.toIso8601String(),
        'declinedDateTime': declinedDateTime.toIso8601String(),
        'oldunit': oldunit
      },
      'jobid': jobid,
      'insertMode': insertMode,
    };
  }
}

class JobImageData with PrintMixin {
  int jobid = 0;
  int clientId = 0;
  String image1 = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";
  String image5 = "";
  String image6 = "";
  String signatureImage = "";

  JobImageData();
  // Method to convert object to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    p('image1 $image1');
    p('oldunit: $clientId jobid: $jobid');
    return {
      'jobid': jobid,
      'clientId': clientId,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'image5': image5,
      'image6': image6,
      'signatureImage': signatureImage,
    };
  }
}
