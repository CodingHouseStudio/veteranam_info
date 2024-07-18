import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

part 'discount_model.freezed.dart';
part 'discount_model.g.dart';

@freezed
class DiscountModel with _$DiscountModel {
  const factory DiscountModel({
    required String id,
    // required DateTime date,
    required List<int> discount,
    required String title,
    required List<String> category,
    required List<String> categoryUA,
    required List<String> subcategory,
    required List<String> subcategoryUA,
    required String eligibility,
    required String description,
    required String requirements,
    required String territory,
    required String expiration,
    required String exclusions,
    required String phoneNumber,
    required DateTime dateVerified,
    required String link,
    List<String>? location,
    String? userId,
    String? html,
    String? userName,
    @ImageConverter() ImageModel? userPhoto,
    String? company,
    String? directLink,
    String? additionalDetails,
    SubLocation? subLocation,
    @Default(false) bool hasMarkdown,
  }) = _DiscountModel;

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
}

enum SubLocation { all, allStoresOfChain, online }

extension SubLocationString on SubLocation? {
  List<String> getList(BuildContext context) {
    switch (this) {
      case null:
        return [];
      case SubLocation.all:
        return [context.l10n.allStoresOfChain, context.l10n.online];
      case SubLocation.allStoresOfChain:
        return [context.l10n.allStoresOfChain];
      case SubLocation.online:
        return [context.l10n.online];
    }
  }
}

abstract class DiscountModelJsonField {
  static const id = 'id';
  static const userId = 'userId';
  static const company = 'company';
  static const discount = 'discount';
  static const title = 'title';
  static const category = 'category';
  static const categoryUA = 'categoryUA';
  static const subcategory = 'subcategory';
  static const subcategoryUA = 'subcategoryUA';
  static const eligibility = 'eligibility';
  static const description = 'description';
  static const requirements = 'requirements';
  static const territory = 'territory';
  static const location = 'location';
  static const expiration = 'expiration';
  static const exclusions = 'exclusions';
  static const phoneNumber = 'phoneNumber';
  static const directLink = 'directLink';
  static const dateVerified = 'dateVerified';
  static const html = 'html';
  static const additionalDetails = 'additionalDetails';
  static const link = 'link';
  static const userName = 'userName';
  static const userPhoto = 'userPhoto';
  // static const date = 'date';
  static const subLocation = 'subLocation';
  static const hasMarkdown = 'hasMarkdown';
}
