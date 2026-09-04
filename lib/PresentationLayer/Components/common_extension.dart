extension FirstOrNullExtension<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}

extension JsonObjectItemExtension on Map<String, dynamic> {
  String parseToString(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToString(data);
    }
    return 'NA';
  }

  String _parseDataToString(dynamic data) {
    if (data is String) {
      return data;
    } else if (data is int || data is double) {
      return data.toString();
    } else if (data is bool) {
      return data.toString();
    } else if (data is List) {
      return "N/A";
    } else if (data is Map) {
      return "N/A";
    }
    return 'NA';
  }

  String parseToDateString(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDateToString(data);
    }
    return 'NA';
  }

  String _parseDateToString(dynamic data) {
    String dateFormate = _parseDataToString(data).replaceAll("T", " ");
    return dateFormate;
  }

  int parseToInt(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToInt(data);
    }
    return -1;
  }

  int _parseDataToInt(dynamic data) {
    if (data is int) {
      return data;
    } else if (data is double) {
      return data.toInt();
    } else if (data is bool) {
      return data ? 1 : 0;
    } else if (data is List) {
      return 0;
    } else if (data is Map) {
      return 0;
    }
    return 0;
  }

  double parseToDouble(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToDouble(data);
    }
    return -1.0;
  }

  double _parseDataToDouble(dynamic data) {
    if (data is double) {
      return data;
    } else if (data is int) {
      return data.toDouble();
    } else if (data is bool) {
      return data ? 1.0 : 0.0;
    } else if (data is List) {
      return 0.0;
    } else if (data is Map) {
      return 0.0;
    }
    return 0.0;
  }

  List<dynamic> parseToList(String key) {
    if (containsKey(key)) {
      var data = this[key];
      return _parseDataToList(data);
    }
    return [];
  }

  List<dynamic> _parseDataToList(dynamic data) {
    if (data is List) {
      return data;
    } else if (data is int) {
      return [];
    } else if (data is double) {
      return [];
    } else if (data is bool) {
      return data ? [] : [];
    } else if (data is Map) {
      return [];
    }
    return [];
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension DateTimeFormatting on String {
  String toFormattedDateTime() {
    try {
      DateTime dateTime = DateTime.parse(this);
      String formattedDate =
          "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
      String formattedTime =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
      return "$formattedDate $formattedTime";
    } catch (e) {
      return "01-01-2024 00:00:00.000";
    }
  }
}
