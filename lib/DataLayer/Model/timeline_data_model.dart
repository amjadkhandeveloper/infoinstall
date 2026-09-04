class TimeLineData {
  final int iD;
  final int userID;

  TimeLineData({
    required this.iD,
    required this.userID,
  });

  factory TimeLineData.fromJson(Map<String, dynamic> json) {
    return TimeLineData(
      iD: json['ID'],
      userID: json['UserId'],
    );
  }
}
