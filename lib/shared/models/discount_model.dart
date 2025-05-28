// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'discount_model.freezed.dart';
part 'discount_model.g.dart';

@freezed
abstract class DiscountModel with _$DiscountModel {
  const factory DiscountModel({
    required String id,
    // required DateTime date,
    required List<int> discount,
    @JsonKey(name: DiscountModelJsonField.title)
    @TranslateConverter()
    required TranslateModel title,
    @JsonKey(name: DiscountModelJsonField.category)
    @TranslateItemsConverter()
    required List<TranslateModel> category,
    // @TranslateItemsOrNullConverter() required List<TranslateModel>?
    // subcategory,
    @JsonKey(name: DiscountModelJsonField.description)
    @TranslateConverter()
    required TranslateModel description,
    @JsonKey(name: DiscountModelJsonField.requirements)
    @TranslateOrNullConverter()
    required TranslateModel? requirements,
    // @TranslateOrNullConverter() required TranslateModel? territory,
    required DateTime dateVerified,
    required String? link,
    @Default([EligibilityEnum.all]) List<EligibilityEnum> eligibility,
    @JsonKey(name: DiscountModelJsonField.exclusions)
    @TranslateOrNullConverter()
    TranslateModel? exclusions,
    String? phoneNumber,
    @JsonKey(name: DiscountModelJsonField.expiration)
    @TranslateOrNullConverter()
    TranslateModel? expiration,
    DateTime? expirationDate,
    @JsonKey(name: DiscountModelJsonField.location)
    @TranslateItemsOrNullConverter()
    List<TranslateModel>? location,
    String? userId,
    // String? html,
    String? userName,
    @ImageConverter() ImageModel? userPhoto,
    @JsonKey(name: DiscountModelJsonField.company)
    @TranslateOrNullConverter()
    TranslateModel? company,
    @Default(DiscountState.isNew) DiscountState status,
    String? directLink,
    // @TranslateOrNullConverter() TranslateModel? additionalDetails,
    SubLocation? subLocation,
    @ImagesConverter() List<ImageModel>? images,
    int? likes,
    @Default(true) bool isVerified,
    // @Default(false) bool hasMarkdown,
  }) = _DiscountModel;

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
}

enum EligibilityEnum {
  all,
  @JsonValue('Veterans')
  veterans,
  @JsonValue('Combatants')
  combatants,
  @JsonValue('Military personnel')
  militaryPersonnel,
  @JsonValue('Persons with disabilities due to war')
  personsWithDisabilitiesDueToWar,
  @JsonValue('Family members of the deceased')
  familyMembersOfTheDeceased,
  @JsonValue('Emergency Service employees')
  emergencyServiceEmployees, // DSNS staff
  @JsonValue('Police officers')
  policeOfficers;
  // internallyDisplacedPersons;

  static List<EligibilityEnum> get valuesWithoutAll => List.generate(
        values.length - 1,
        (index) => values.elementAt(index + 1),
        growable: false,
      );
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

  bool get showDeactivateButton =>
      this == DiscountState.published || this == DiscountState.deactivated;

  bool get isPublished => this == DiscountState.published;
  bool get isRejected => this == DiscountState.rejected;
}

abstract class DiscountModelJsonField {
  static const id = 'id';
  static const userId = 'userId';
  static const company = 'companyT';
  // static const companyEN = 'companyEN';
  static const discount = 'discount';
  static const title = 'titleT';
  // static const titleEN = 'titleEN';
  static const category = 'categoryT';
  // static const categoryEN = 'categoryEN';
  // static const subcategory = 'subcategory';
  // static const subcategoryEN = 'subcategoryEN';
  static const eligibility = 'eligibility';
  static const description = 'descriptionT';
  // static const descriptionEN = 'descriptionEN';
  static const requirements = 'requirementsT';
  // static const requirementsEN = 'requirementsEN';
  // static const territory = 'territory';
  // static const territoryEN = 'territoryEN';
  static const location = 'locationT';
  // static const locationEN = 'locationEN';
  static const expiration = 'expirationT';
  // static const expirationEN = 'expirationEN';
  static const exclusions = 'exclusionsT';
  // static const exclusionsEN = 'exclusionsEN';
  static const phoneNumber = 'phoneNumber';
  static const directLink = 'directLink';
  static const dateVerified = 'dateVerified';
  // static const html = 'html';
  // static const additionalDetails = 'additionalDetails';
  // static const additionalDetailsEN = 'additionalDetailsEN';
  static const link = 'link';
  static const userName = 'userName';
  static const userPhoto = 'userPhoto';
  // static const date = 'date';
  static const subLocation = 'subLocation';
  // static const hasMarkdown = 'hasMarkdown';
  static const status = 'status';
  static const images = 'images';
  static const likes = 'likes';
  static const isVerified = 'isVerified';
  static const expirationDate = 'expirationDate';
}
