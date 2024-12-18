import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'discount_model.freezed.dart';
part 'discount_model.g.dart';

@freezed
class DiscountModel with _$DiscountModel {
  const factory DiscountModel({
    required String id,
    // required DateTime date,
    required List<int> discount,
    @TranslateConverter() required TranslateModel title,
    @TranslateItemsConverter() required List<TranslateModel> category,
    // @TranslateItemsOrNullConverter() required List<TranslateModel>?
    // subcategory,
    @TranslateConverter() required TranslateModel description,
    @TranslateOrNullConverter() required TranslateModel? requirements,
    // @TranslateOrNullConverter() required TranslateModel? territory,
    required DateTime dateVerified,
    required String? link,
    @Default([EligibilityEnum.all]) List<EligibilityEnum> eligibility,
    @TranslateOrNullConverter() TranslateModel? exclusions,
    String? phoneNumber,
    @TranslateOrNullConverter() TranslateModel? expiration,
    @TranslateItemsOrNullConverter() List<TranslateModel>? location,
    String? userId,
    // String? html,
    String? userName,
    @ImageConverter() ImageModel? userPhoto,
    @TranslateOrNullConverter() TranslateModel? company,
    @Default(DiscountState.isNew) DiscountState status,
    String? directLink,
    // @TranslateOrNullConverter() TranslateModel? additionalDetails,
    SubLocation? subLocation,
    @ImagesConverter() List<ImageModel>? images,
    int? likes,
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
  // static const subcategory = 'subcategory';
  // static const subcategoryEN = 'subcategoryEN';
  static const eligibility = 'eligibility';
  static const description = 'description';
  static const descriptionEN = 'descriptionEN';
  static const requirements = 'requirements';
  static const requirementsEN = 'requirementsEN';
  // static const territory = 'territory';
  // static const territoryEN = 'territoryEN';
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
}
