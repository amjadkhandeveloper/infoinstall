class ProfileRequest {
  int userId;

  ProfileRequest({
    required this.userId,
  });

  factory ProfileRequest.fromJson(Map<String, dynamic> json) {
    return ProfileRequest(
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}
