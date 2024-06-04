import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount_model.freezed.dart';

part 'discount_model.g.dart';

@freezed
class DiscountModel with _$DiscountModel {
  const factory DiscountModel({
    required String id,
    required String userId,
    required String service,
    required String percent,
    required String city,
    required String comment,
    required DateTime date,
    required String instruction,
    required List<String> tags,
  }) = _DiscountModel;

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
}
