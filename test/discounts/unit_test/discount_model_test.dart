import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/extension/extension_dart_constants.dart';
// import 'package:veteranam/shared/extension/list_extension_dart.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.discount} ${KGroupText.model} ', () {
    final fullJson = {
      DiscountModelJsonField.id: KTestVariables.discountModelItems.last.id,
      DiscountModelJsonField.userId:
          KTestVariables.discountModelItems.last.userId,
      // DiscountModelJsonField.additionalDetails:
      //     KTestVariables.discountModelItems.last.additionalDetails,
      DiscountModelJsonField.category:
          KTestVariables.discountModelItems.last.category
              .map(
                (e) => e.toJson(),
              )
              .toList(),
      // DiscountModelJsonField.categoryEN:
      //     KTestVariables.discountModelItems.last.category.getTrsnslation(
      //   isEnglish: false,
      // ),
      DiscountModelJsonField.company:
          KTestVariables.discountModelItems.last.company!.toJson(),
      DiscountModelJsonField.dateVerified:
          KTestVariables.discountModelItems.last.dateVerified.toIso8601String(),
      DiscountModelJsonField.description:
          KTestVariables.discountModelItems.last.description.toJson(),
      DiscountModelJsonField.directLink:
          KTestVariables.discountModelItems.last.directLink,
      DiscountModelJsonField.discount:
          KTestVariables.discountModelItems.last.discount,
      // DiscountModelJsonField.eligibility:
      //     KTestVariables.discountModelItems.last.eligibility,
      DiscountModelJsonField.exclusions:
          KTestVariables.discountModelItems.last.exclusions!.toJson(),
      DiscountModelJsonField.expiration:
          KTestVariables.discountModelItems.last.expiration!.toJson(),
      // DiscountModelJsonField.html: KTestVariables.discountModelItems.
      // last.html,
      DiscountModelJsonField.link: KTestVariables.discountModelItems.last.link,
      DiscountModelJsonField.location:
          KTestVariables.discountModelItems.last.location!
              .map(
                (e) => e.toJson(),
              )
              .toList(),
      DiscountModelJsonField.phoneNumber:
          KTestVariables.discountModelItems.last.phoneNumber,
      DiscountModelJsonField.requirements:
          KTestVariables.discountModelItems.last.requirements?.toJson(),
      DiscountModelJsonField.subLocation:
          KTestVariables.discountModelItems.last.subLocation,
      // DiscountModelJsonField.subcategory:
      //     KTestVariables.discountModelItems.last.subcategory,
      // DiscountModelJsonField.subcategoryEN: KTestVariables
      //     .discountModelItems.last.subcategory
      //     ?.getTrsnslation(isEnglish: false),
      // DiscountModelJsonField.territory:
      //     KTestVariables.discountModelItems.last.territory,
      DiscountModelJsonField.title:
          KTestVariables.discountModelItems.last.title.toJson(),
      DiscountModelJsonField.userName:
          KTestVariables.discountModelItems.last.userName,
      // DiscountModelJsonField.titleEN:
      //     KTestVariables.discountModelItems.last.title.uk,
      // DiscountModelJsonField.locationEN: KTestVariables
      //     .discountModelItems.last.location
      //     ?.getTrsnslation(isEnglish: false),
      // DiscountModelJsonField.territoryEN:
      //     KTestVariables.discountModelItems.last.territory?.uk,
      // DiscountModelJsonField.exclusionsEN:
      //     KTestVariables.discountModelItems.last.exclusions?.uk,
      // DiscountModelJsonField.expirationEN:
      //     KTestVariables.discountModelItems.last.expiration?.uk,
      // DiscountModelJsonField.descriptionEN:
      //     KTestVariables.discountModelItems.last.description.uk,
      // DiscountModelJsonField.eligibilityEN:
      //     KTestVariables.discountModelItems.last.eligibilityEN,
      // DiscountModelJsonField.requirementsEN:
      //     KTestVariables.discountModelItems.last.requirements?.uk,
      // DiscountModelJsonField.companyEN:
      //     KTestVariables.discountModelItems.last.company?.uk,
      // DiscountModelJsonField.additionalDetailsEN:
      //     KTestVariables.discountModelItems.last.additionalDetails?.uk,
      DiscountModelJsonField.userPhoto: [
        KTestVariables.discountModelItems.last.userPhoto!.toJson(),
      ],
      DiscountModelJsonField.status:
          KTestVariables.discountModelItems.last.status.enumString,
      DiscountModelJsonField.eligibility: KTestVariables
          .discountModelItems.last.eligibility
          .map((e) => _$EligibilityEnumEnumMap[e]!)
          .toList(),
      DiscountModelJsonField.images: [KTestVariables.imageModel.toJson()],
      DiscountModelJsonField.likes:
          KTestVariables.discountModelItems.last.likes,
      DiscountModelJsonField.isVerified: false,
      // DiscountModelJsonField.eligibilityEN: KTestVariables
      //     .discountModelItems.last.eligibility
      //     ?.getTrsnslation(isEnglish: false),
      // DiscountModelJsonField.hasMarkdown:
      //     KTestVariables.discountModelItems.last.hasMarkdown,
      // DiscountModelJsonField.date:
      //     KTestVariables.discountModelItems.last.date.toIso8601String(),
    };
    final nullableJson = {
      DiscountModelJsonField.id: KTestVariables.discountModelItems.last.id,
      DiscountModelJsonField.userId: null,
      DiscountModelJsonField.category:
          KTestVariables.discountModelItems.last.category
              .map(
                (e) => e.toJson(),
              )
              .toList(),
      // DiscountModelJsonField.categoryEN: null,
      DiscountModelJsonField.company: null,
      DiscountModelJsonField.dateVerified:
          KTestVariables.discountModelItems.last.dateVerified.toIso8601String(),
      DiscountModelJsonField.description:
          KTestVariables.discountModelItems.last.description.toJson(),
      DiscountModelJsonField.link: KTestVariables.discountModelItems.last.link,
      DiscountModelJsonField.discount:
          KTestVariables.discountModelItems.last.discount,
      // DiscountModelJsonField.eligibility:
      //     KTestVariables.discountModelItems.last.eligibility,
      DiscountModelJsonField.exclusions: null,
      DiscountModelJsonField.expiration: null,
      DiscountModelJsonField.phoneNumber: null,
      DiscountModelJsonField.requirements: null,
      // DiscountModelJsonField.subcategory:?.toJson() null,
      // DiscountModelJsonField.subcategoryEN: null,
      // DiscountModelJsonField.territory:
      //     KTestVariables.discountModelItems.last.territory,
      DiscountModelJsonField.title:
          KTestVariables.discountModelItems.last.title.toJson(),
      // DiscountModelJsonField.titleEN: null,
      // DiscountModelJsonField.territoryEN: null,
      // DiscountModelJsonField.exclusionsEN: null,
      // DiscountModelJsonField.descriptionEN: null,
      // DiscountModelJsonField.eligibilityEN:
      //     KTestVariables.discountModelItems.last.eligibilityEN,
      // DiscountModelJsonField.requirementsEN: null,
      // DiscountModelJsonField.expirationEN: null,
      // DiscountModelJsonField.locationEN: null,
      // DiscountModelJsonField.hasMarkdown:
      //     KTestVariables.discountModelItems.last.hasMarkdown,
      DiscountModelJsonField.userPhoto: null,
      DiscountModelJsonField.subLocation: null,
      DiscountModelJsonField.location: null,
      // DiscountModelJsonField.date:
      //     KTestVariables!.first.toJson().
      // discountModelItems.last.date.toIso8601String(),
      DiscountModelJsonField.directLink: null,
      // DiscountModelJsonField.html: null,
      // DiscountModelJsonField.additionalDetails: null,
      DiscountModelJsonField.userName: null,
      // DiscountModelJsonField.additionalDetailsEN: null,
      // DiscountModelJsonField.companyEN: null,
      DiscountModelJsonField.status: null,
      DiscountModelJsonField.eligibility: [
        _$EligibilityEnumEnumMap[EligibilityEnum.all]!,
      ],
      DiscountModelJsonField.images: null,
      DiscountModelJsonField.likes: null,
      DiscountModelJsonField.isVerified: true,
      // DiscountModelJsonField.eligibilityEN: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final discountModel = DiscountModel.fromJson(fullJson);

        expect(
          discountModel.id,
          KTestVariables.discountModelItems.last.id,
        );
        expect(
          discountModel.title,
          KTestVariables.discountModelItems.last.title,
        );
        expect(
          discountModel.userId,
          KTestVariables.discountModelItems.last.userId,
        );
        // expect(
        //   discountModel.additionalDetails,
        //   KTestVariables.discountModelItems.last.additionalDetails,
        // );
        expect(
          discountModel.category,
          KTestVariables.discountModelItems.last.category,
        );
        // expect(
        //   discountModel.categoryEN,
        //   KTestVariables.discountModelItems.last.categoryEN,
        // );
        expect(
          discountModel.company,
          KTestVariables.discountModelItems.last.company,
        );
        expect(
          discountModel.dateVerified,
          KTestVariables.discountModelItems.last.dateVerified,
        );
        expect(
          discountModel.description,
          KTestVariables.discountModelItems.last.description,
        );
        expect(
          discountModel.directLink,
          KTestVariables.discountModelItems.last.directLink,
        );
        expect(
          discountModel.discount,
          KTestVariables.discountModelItems.last.discount,
        );
        // expect(
        //   discountModel.eligibility,
        //   KTestVariables.discountModelItems.last.eligibility,
        // );
        expect(
          discountModel.exclusions,
          KTestVariables.discountModelItems.last.exclusions,
        );
        expect(
          discountModel.expiration,
          KTestVariables.discountModelItems.last.expiration,
        );
        // expect(
        //   discountModel.html,
        //   KTestVariables.discountModelItems.last.html,
        // );
        expect(
          discountModel.link,
          KTestVariables.discountModelItems.last.link,
        );
        expect(
          discountModel.location,
          KTestVariables.discountModelItems.last.location,
        );
        expect(
          discountModel.phoneNumber,
          KTestVariables.discountModelItems.last.phoneNumber,
        );
        expect(
          discountModel.requirements,
          KTestVariables.discountModelItems.last.requirements,
        );
        expect(
          discountModel.subLocation,
          KTestVariables.discountModelItems.last.subLocation,
        );
        // expect(
        //   discountModel.subcategory,
        //   KTestVariables.discountModelItems.last.subcategory,
        // );
        // expect(
        //   discountModel.subcategoryEN,
        //   KTestVariables.discountModelItems.last.subcategoryEN,
        // );
        // expect(
        //   discountModel.territory,
        //   KTestVariables.discountModelItems.last.territory,
        // );
        expect(
          discountModel.userName,
          KTestVariables.discountModelItems.last.userName,
        );
        expect(
          discountModel.userPhoto,
          KTestVariables.discountModelItems.last.userPhoto,
        );
        // expect(
        //   discountModel.titleEN,
        //   KTestVariables.discountModelItems.last.titleEN,
        // );
        // expect(
        //   discountModel.locationEN,
        //   KTestVariables.discountModelItems.last.locationEN,
        // );
        // expect(
        //   discountModel.territoryEN,
        //   KTestVariables.discountModelItems.last.territoryEN,
        // );
        // expect(
        //   discountModel.exclusionsEN,
        //   KTestVariables.discountModelItems.last.exclusionsEN,
        // );
        // expect(
        //   discountModel.expirationEN,
        //   KTestVariables.discountModelItems.last.expirationEN,
        // );
        // expect(
        //   discountModel.descriptionEN,
        //   KTestVariables.discountModelItems.last.descriptionEN,
        // );
        // expect(
        //   discountModel.companyEN,
        //   KTestVariables.discountModelItems.last.companyEN,
        // );
        // expect(
        //   discountModel.eligibilityEN,
        //   KTestVariables.discountModelItems.last.eligibilityEN,
        // );
        // expect(
        //   discountModel.requirementsEN,
        //   KTestVariables.discountModelItems.last.requirementsEN,
        // );
        expect(
          discountModel.status,
          KTestVariables.discountModelItems.last.status,
        );
        expect(
          discountModel.eligibility,
          KTestVariables.discountModelItems.last.eligibility,
        );
        // expect(
        //   discountModel.eligibilityEN,
        //   KTestVariables.discountModelItems.last.eligibilityEN,
        // );
        // expect(
        //   discountModel.date,
        //   KTestVariables.discountModelItems.last.date,
        // );
        expect(
          discountModel.images,
          isNotNull,
        );
        expect(
          discountModel.images!.first,
          KTestVariables.imageModel,
        );
        expect(
          discountModel.likes,
          KTestVariables.discountModelItems.last.likes,
        );
        expect(
          discountModel.isVerified,
          false,
        );
      });

      test('${KGroupText.nullable} ', () {
        final discountModel = DiscountModel.fromJson(nullableJson);

        expect(
          discountModel.id,
          KTestVariables.discountModelItems.last.id,
        );
        expect(
          discountModel.title,
          KTestVariables.discountModelItems.last.title,
        );
        expect(
          discountModel.userId,
          null,
        );
        // expect(
        //   discountModel.additionalDetails,
        //   null,
        // );
        expect(
          discountModel.category,
          KTestVariables.discountModelItems.last.category,
        );
        // expect(
        //   discountModel.categoryEN,
        //   null,
        // );
        expect(
          discountModel.company,
          null,
        );
        expect(
          discountModel.dateVerified,
          KTestVariables.discountModelItems.last.dateVerified,
        );
        expect(
          discountModel.description,
          KTestVariables.discountModelItems.last.description,
        );
        expect(
          discountModel.link,
          KTestVariables.discountModelItems.last.link,
        );
        expect(
          discountModel.discount,
          KTestVariables.discountModelItems.last.discount,
        );
        expect(
          discountModel.isVerified,
          true,
        );
        // expect(
        //   discountModel.eligibility,
        //   KTestVariables.discountModelItems.last.eligibility,
        // );
        expect(
          discountModel.exclusions,
          null,
        );
        expect(
          discountModel.expiration,
          null,
        );
        // expect(
        //   discountModel.html,
        //   null,
        // );
        expect(
          discountModel.directLink,
          null,
        );
        expect(
          discountModel.location,
          null,
        );
        expect(
          discountModel.phoneNumber,
          null,
        );
        expect(
          discountModel.requirements,
          null,
        );
        expect(
          discountModel.subLocation,
          null,
        );
        // expect(
        //   discountModel.subcategory,
        //   null,
        // );
        // expect(
        //   discountModel.subcategoryEN,
        //   null,
        // );
        // expect(
        //   discountModel.territory,
        //   KTestVariables.discountModelItems.last.territory,
        // );
        expect(
          discountModel.userName,
          null,
        );
        expect(
          discountModel.userPhoto,
          null,
        );
        // expect(
        //   discountModel.titleEN,
        //   null,
        // );
        // expect(
        //   discountModel.locationEN,
        //   null,
        // );
        // expect(
        //   discountModel.territoryEN,
        //   null,
        // );
        // expect(
        //   discountModel.exclusionsEN,
        //   null,
        // );
        // expect(
        //   discountModel.expirationEN,
        //   null,
        // );
        // expect(
        //   discountModel.descriptionEN,
        //   null,
        // );
        // expect(
        //   discountModel.eligibilityEN,
        //   KTestVariables.discountModelItems.last.eligibilityEN,
        // );
        // expect(
        //   discountModel.requirementsEN,
        //   null,
        // );
        // expect(
        //   discountModel.companyEN,
        //   null,
        // );
        // expect(
        //   discountModel.eligibility,
        //   null,
        // );
        // expect(
        //   discountModel.eligibilityEN,
        //   null,
        // );
        expect(
          discountModel.status,
          DiscountState.isNew,
        );
        // expect(
        //   discountModel.date,
        //   KTestVariables.discountModelItems.last.date,
        // );
        expect(
          discountModel.images,
          null,
        );
        expect(
          discountModel.likes,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
        // title is missing
        final json = {
          DiscountModelJsonField.id: KTestVariables.discountModelItems.last.id,
          // title is missing
          DiscountModelJsonField.userId:
              KTestVariables.discountModelItems.last.userId,
          DiscountModelJsonField.userName:
              KTestVariables.discountModelItems.last.userName,
          // DiscountModelJsonField.additionalDetails:
          //     KTestVariables.discountModelItems.last.additionalDetails,
          DiscountModelJsonField.category:
              KTestVariables.discountModelItems.last.category.map(
            (e) => e.toJson(),
          ),
          // DiscountModelJsonField.categoryEN: KTestVariables
          //     .discountModelItems.last.category
          //     .getTrsnslation(isEnglish: false),
          DiscountModelJsonField.company:
              KTestVariables.discountModelItems.last.company,
          DiscountModelJsonField.dateVerified: KTestVariables
              .discountModelItems.last.dateVerified
              .toIso8601String(),
          DiscountModelJsonField.description:
              KTestVariables.discountModelItems.last.description.toJson(),
          DiscountModelJsonField.directLink:
              KTestVariables.discountModelItems.last.directLink,
          DiscountModelJsonField.discount:
              KTestVariables.discountModelItems.last.discount,
          // DiscountModelJsonField.eligibility:
          //     KTestVariables.discountModelItems.last.eligibility,
          DiscountModelJsonField.exclusions:
              KTestVariables.discountModelItems.last.exclusions!.toJson(),
          DiscountModelJsonField.expiration:
              KTestVariables.discountModelItems.last.expiration!.toJson(),
          // DiscountModelJsonField.html: KTestVariables.discountModelItems.last
          // .html,
          DiscountModelJsonField.link:
              KTestVariables.discountModelItems.last.link,
          DiscountModelJsonField.location:
              KTestVariables.discountModelItems.last.location!.first.toJson(),
          DiscountModelJsonField.phoneNumber:
              KTestVariables.discountModelItems.last.phoneNumber,
          DiscountModelJsonField.requirements:
              KTestVariables.discountModelItems.last.requirements?.toJson(),
          DiscountModelJsonField.subLocation:
              KTestVariables.discountModelItems.last.subLocation,
          // DiscountModelJsonField.subcategory:
          //     KTestVariables.discountModelItems.last.subcategory,
          // DiscountModelJsonField.subcategoryEN: KTestVariables
          //     .discountModelItems.last.subcategory
          //     ?.getTrsnslation(isEnglish: false),
          // DiscountModelJsonField.territory:
          //     KTestVariables.discountModelItems.last.territory,
          // DiscountModelJsonField.titleEN:
          //     KTestVariables.discountModelItems.last.title.uk,
          // DiscountModelJsonField.locationEN: KTestVariables
          //     .discountModelItems.last.location
          //     ?.getTrsnslation(isEnglish: false),
          // DiscountModelJsonField.territoryEN:
          //     KTestVariables.discountModelItems.last.territory?.uk,
          // DiscountModelJsonField.exclusionsEN:
          //     KTestVariables.discountModelItems.last.exclusions?.uk,
          // DiscountModelJsonField.expirationEN:
          //     KTestVariables.discountModelItems.last.expiration?.uk,
          // DiscountModelJsonField.descriptionEN:
          //     KTestVariables.discountModelItems.last.description.uk,
          // DiscountModelJsonField.eligibilityEN:
          //     KTestVariables.discountModelItems.last.eligibilityEN,
          // DiscountModelJsonField.requirementsEN:
          //     KTestVariables.discountModelItems.last.requirements?.uk,
          // DiscountModelJsonField.companyEN:
          //     KTestVariables.discountModelItems.last.company?.uk,
          // DiscountModelJsonField.date:
          //     KTestVariables.discountModelItems.last.date.toIso8601String(),
          DiscountModelJsonField.images: KTestVariables.imagesList,
          DiscountModelJsonField.likes:
              KTestVariables.discountModelItems.last.likes,
          DiscountModelJsonField.isVerified: true,
        };

        expect(
          () => DiscountModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final discountModelJson = KTestVariables.discountModelItems.last
            .copyWith(
              images: KTestVariables.imagesList,
              isVerified: false,
            )
            .toJson();

        expect(discountModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final discountModelJson = KTestVariables.discountModelItems.last
            .copyWith(
              directLink: null,
              // additionalDetails: null,
              // html: null,
              userId: null,
              userName: null,
              company: null,
              location: null,
              subLocation: null,
              userPhoto: null,
              phoneNumber: null,
              expiration: null,
              requirements: null,
              status: DiscountState.isNew,
              // subcategory: null,
              exclusions: null,
              eligibility: const [EligibilityEnum.all],
              likes: null,
              isVerified: true,
            )
            .toJson();

        expect(
          discountModelJson,
          nullableJson
            ..update(
              DiscountModelJsonField.status,
              (value) => DiscountState.isNew.enumString,
            ),
        );
      });
    });
  });
}

const _$EligibilityEnumEnumMap = {
  EligibilityEnum.all: 'all',
  EligibilityEnum.veterans: 'Veterans',
  EligibilityEnum.combatants: 'Combatants',
  EligibilityEnum.militaryPersonnel: 'Military personnel',
  EligibilityEnum.personsWithDisabilitiesDueToWar:
      'Persons with disabilities due to war',
  EligibilityEnum.familyMembersOfTheDeceased: 'Family members of the deceased',
  EligibilityEnum.emergencyServiceEmployees: 'Emergency Service employees',
  EligibilityEnum.policeOfficers: 'Police officers',
};
