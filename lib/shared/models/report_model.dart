import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/l10n/l10n.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

enum ReasonComplaint {
  fraudOrSpam,
  fakeNewsOrDisinformation,
  offensiveOrHatefulContent,
  other,
}

enum CardEnum {
  funds,
  discount,
  information,
  story,
}

extension ReasonComplaintText on ReasonComplaint {
  String toText(BuildContext context) {
    switch (this) {
      case ReasonComplaint.fakeNewsOrDisinformation:
        return context.l10n.fakeNewsOrDisinformation;
      case ReasonComplaint.fraudOrSpam:
        return context.l10n.fraudOrSpam;
      case ReasonComplaint.offensiveOrHatefulContent:
        return context.l10n.offensiveOrHatefulContent;
      case ReasonComplaint.other:
        return context.l10n.other;
    }
  }
}

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    required String id,
    required ReasonComplaint reasonComplaint,
    // required String email,
    required String? message,
    required DateTime date,
    required CardEnum card,
    required String userId,
    required String cardId,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}

abstract class ReportModelJsonField {
  static const id = 'id';
  static const date = 'date';
  // static const email = 'email';
  static const message = 'message';
  static const reasonComplaint = 'reasonComplaint';
  static const card = 'card';
  static const userId = 'userId';
  static const cardId = 'cardId';
}
