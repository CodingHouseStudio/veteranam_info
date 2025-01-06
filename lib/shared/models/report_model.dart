import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

enum ReportStatus {
  isNew,
  critical,
  resolved,
  // ideas,
}

enum ReasonComplaint {
  fraudOrSpam,
  fakeNewsOrDisinformation,
  offensiveOrHatefulContent,
  other;

  bool get isOther => this == ReasonComplaint.other;
}

enum CardEnum {
  funds,
  discount,
  information,
  story,
}

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    required String id,
    required ReasonComplaint reasonComplaint,
    required String? email,
    required String? message,
    required DateTime date,
    required CardEnum card,
    required String userId,
    required String cardId,
    @Default(ReportStatus.isNew) ReportStatus status,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}

abstract class ReportModelJsonField {
  static const id = 'id';
  static const date = 'date';
  static const email = 'email';
  static const message = 'message';
  static const reasonComplaint = 'reasonComplaint';
  static const card = 'card';
  static const userId = 'userId';
  static const cardId = 'cardId';
  static const status = 'status';
}
