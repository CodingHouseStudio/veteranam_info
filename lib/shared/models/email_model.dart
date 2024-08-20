import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_model.freezed.dart';
part 'email_model.g.dart';

enum DiscountEmailStatus {
  isNew,
  responseRequired,
  resolved,
  ideas,
}

@freezed
class EmailModel with _$EmailModel {
  const factory EmailModel({
    required String id,
    required String userId,
    required String? email,
    required DateTime date,
  }) = _EmailModel;

  factory EmailModel.fromJson(Map<String, dynamic> json) =>
      _$EmailModelFromJson(json);
}

abstract class EmailModelJsonField {
  static const id = 'id';
  static const userId = 'userId';
  static const email = 'email';
  static const date = 'date';
}
