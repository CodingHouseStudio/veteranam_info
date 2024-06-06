import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount_model.freezed.dart';

part 'discount_model.g.dart';

@freezed
class DiscountModel with _$DiscountModel {
  const factory DiscountModel({
    required String id,
    required String userId,
    required String company,
    required int discount,
    required String title,
    required List<String> category,
    required List<String> categoryUA,
    required List<String> subcategory,
    required List<String> subcategoryUA,
    required String eligibility,
    required String description,
    required String requirements,
    required String territory,
    required String location,
    required String expiration,
    required String exclusions,
    required String phoneNumber,
    required String directLink,
    required DateTime dateVerified,
    String? html,
    String? additionaldetails,
    String? link,
    @Default(true) bool selectedLocationsOnly,

    // required String service,
    // required String city,
    // required String comment,
    // required DateTime date,
    // required String instruction,
    // required List<String> tags,
  }) = _DiscountModel;

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
}
