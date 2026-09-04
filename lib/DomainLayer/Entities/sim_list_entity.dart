import 'package:infoinstall/DataLayer/Model/get_sim_list_model.dart';

class SimList {
  final int status;
  final List<SimData> data;

  SimList({
    required this.status,
    required this.data,
  });
  factory SimList.fromJson(Map<String, dynamic> json) {
    var availablesim = json['availablesim'] as List?;
    print('availablesim ${availablesim != null ? availablesim.length : 0}');
    return SimList(
      status: json['status'] ?? 0,
      // data: json['availablesim'] != null && json['availablesim'] is List
      //     ? (json['availablesim'] as List)
      //         .map((sim) => SimData.fromJson(sim))
      //         .toList()
      //     : [], // Return an empty list if availablesim is null or not a list

      data: availablesim != null
          ? availablesim.map((sim) => SimData.fromJson(sim)).toList()
          : [],
    );
  }

  List<SimData> parseSimData(Map<String, dynamic> json) {
    var data = json['availablesim'] as List?;
    return data != null
        ? data.map((sim) => SimData.fromJson(sim)).toList()
        : []; // Return an empty list if data is null
  }

  // factory SimList.fromJson(Map<String, dynamic> json) {
  //   return SimList(
  //     status: json['status'] ?? 0,
  //     data: (json['availablesim'] as List)
  //         .map((sim) => SimData.fromJson(sim))
  //         .toList(),
  //   );
  // }

  // List<SimData> parseSimData(Map<String, dynamic> json) {
  //   var data = json['availablesim'] as List;
  //   return data.map((sim) => SimData.fromJson(sim)).toList();
  // }
}
