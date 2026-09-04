import 'dart:convert';

class RemoveDeviceData {
  int jobid = 0;
  String unitId = '0';

  RemoveDeviceData();

  // Method to convert object to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'jobid': jobid,
    };
  }
}
