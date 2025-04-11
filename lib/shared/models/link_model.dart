import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_model.freezed.dart';
part 'link_model.g.dart';

enum DiscountLinkStatus {
  isNew,
  responseRequired,
  resolved,
  ideas,
}

@freezed
sealed class LinkModel with _$LinkModel {
  const factory LinkModel({
    required String id,
    required String userId,
    required String link,
    required DateTime date,
  }) = _LinkModel;

  factory LinkModel.fromJson(Map<String, dynamic> json) =>
      _$LinkModelFromJson(json);
}

abstract class LinkModelJsonField {
  static const id = 'id';
  static const userId = 'userId';
  static const link = 'link';
  static const date = 'date';
}
