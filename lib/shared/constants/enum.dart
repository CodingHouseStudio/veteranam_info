extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;

  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }
}

enum LoadingStatus { initial, loading, loaded, error }

enum FieldEnum {
  initial,
  inProgress,
  success,
  invalidData,
}
