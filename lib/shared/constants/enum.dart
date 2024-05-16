import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;
  static String? _id;

  static DateTime get current => _customTime ?? DateTime.now().toUtc();

  static String get id =>
      _id ?? DateTime.now().toLocal().microsecondsSinceEpoch.toString();

  @visibleForTesting
  static set customTime(DateTime customTime) => _customTime = customTime;

  @visibleForTesting
  static set id(String customId) => _id = customId;

  String get localeTime => toLocal().toString().split(' ')[0];
}

extension ExtendedImage on List<ImageModel>? {
  String? get firstImage =>
      this?.isNotEmpty ?? false ? this!.first.downloadURL : null;
}

enum LoadingStatus { initial, loading, loaded, error }

enum EvaluationEnum { like, dislike, smile, none }
