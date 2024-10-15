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
    required String? titleEN,
    required List<String> category,
    required List<String>? categoryEN,
    required List<String>? subcategory,
    required List<String>? subcategoryEN,
    required String description,
    required String? descriptionEN,
    required String? requirements,
    required String? requirementsEN,
    required String? territory,
    required String? territoryEN,
    required DateTime dateVerified,
    required String link,
    List<String>? eligibility,
    List<String>? eligibilityEN,
    String? exclusions,
    String? exclusionsEN,
    String? phoneNumber,
    String? expiration,
    String? expirationEN,
    List<String>? location,
    List<String>? locationEN,
    String? userId,
    // String? html,
    String? userName,
    @ImageConverter() ImageModel? userPhoto,
    String? company,
    @Default(DiscountState.isNew) DiscountState status,
    String? companyEN,
    String? directLink,
    String? additionalDetails,
    String? additionalDetailsEN,
    SubLocation? subLocation,
    // @Default(false) bool hasMarkdown,
  }) = _DiscountModel;

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
}

enum SubLocation {
  all,
  allStoresOfChain,
  online;

  bool get isOnline => this == SubLocation.online;
}

enum DiscountState {
  isNew,
  underReview,
  rejected,
  published,
  deactivated;
}

extension SubLocationString on SubLocation {
  List<String> getList(BuildContext context) {
    switch (this) {
      // case null:
      //   return [];
      case SubLocation.all:
      case SubLocation.allStoresOfChain:
      case SubLocation.online:
        return [context.l10n.allUkraine];
    }
  }

  List<String> getCardList(BuildContext context) {
    switch (this) {
      case SubLocation.all:
        return [context.l10n.allStoresOfChain, context.l10n.allUkrainOnline];
      case SubLocation.allStoresOfChain:
        return [context.l10n.allStoresOfChain];
      case SubLocation.online:
        return [context.l10n.allUkrainOnline];
    }
  }
}

abstract class DiscountModelJsonField {
  static const id = 'id';
  static const userId = 'userId';
  static const company = 'company';
  static const companyEN = 'companyEN';
  static const discount = 'discount';
  static const title = 'title';
  static const titleEN = 'titleEN';
  static const category = 'category';
  static const categoryEN = 'categoryEN';
  static const subcategory = 'subcategory';
  static const subcategoryEN = 'subcategoryEN';
  static const eligibility = 'eligibility';
  static const eligibilityEN = 'eligibilityEN';
  static const description = 'description';
  static const descriptionEN = 'descriptionEN';
  static const requirements = 'requirements';
  static const requirementsEN = 'requirementsEN';
  static const territory = 'territory';
  static const territoryEN = 'territoryEN';
  static const location = 'location';
  static const locationEN = 'locationEN';
  static const expiration = 'expiration';
  static const expirationEN = 'expirationEN';
  static const exclusions = 'exclusions';
  static const exclusionsEN = 'exclusionsEN';
  static const phoneNumber = 'phoneNumber';
  static const directLink = 'directLink';
  static const dateVerified = 'dateVerified';
  // static const html = 'html';
  static const additionalDetails = 'additionalDetails';
  static const additionalDetailsEN = 'additionalDetailsEN';
  static const link = 'link';
  static const userName = 'userName';
  static const userPhoto = 'userPhoto';
  // static const date = 'date';
  static const subLocation = 'subLocation';
  // static const hasMarkdown = 'hasMarkdown';
  static const status = 'status';
}
