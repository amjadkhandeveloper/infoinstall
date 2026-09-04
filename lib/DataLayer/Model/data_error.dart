// Data error class
class DataError {
  String? message;

  DataError({
    this.message,
  });

  DataError.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
