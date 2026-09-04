import '../../DataLayer/Model/dashbaord_item.dart';

class DashboardCountDetails {
  final int status;
  final String message;
  final List<DashboardCountDetailsModel> datefilterjobcount;
  final List<DashboardCountDetailsModel> todaysjobcount;

  DashboardCountDetails({
    required this.status,
    required this.message,
    required this.datefilterjobcount,
    required this.todaysjobcount,
  });

  factory DashboardCountDetails.fromJson(Map<String, dynamic> json) {
    return DashboardCountDetails(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      datefilterjobcount: (json['datefilterjobcount'] as List)
          .map((datefilterjobcount) =>
              DashboardCountDetailsModel.fromJson(datefilterjobcount))
          .toList(),
      todaysjobcount: (json['todaysjobcount'] as List)
          .map((todaysjobcount) =>
              DashboardCountDetailsModel.fromJson(todaysjobcount))
          .toList(),
    );
  }
}
