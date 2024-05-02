extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;
  static String? _id;

  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static String get id {
    return _id ?? DateTime.now().microsecondsSinceEpoch.toString();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }

  static set id(String customId) {
    _id = customId;
  }
}

enum LoadingStatus { initial, loading, loaded, error }

enum EvaluationEnum { like, dislike, smile, none }
