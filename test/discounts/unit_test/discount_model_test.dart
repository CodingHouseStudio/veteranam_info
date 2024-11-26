import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/extension/extension_dart_constants.dart';
import 'package:veteranam/shared/extension/list_extension_dart.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} ${KGroupText.model} ', () {
    final fullJson = {
      DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
      DiscountModelJsonField.userId: KTestText.discountModelItems.last.userId,
      DiscountModelJsonField.additionalDetails:
          KTestText.discountModelItems.last.additionalDetails,
      DiscountModelJsonField.category:
          KTestText.discountModelItems.last.category,
      DiscountModelJsonField.categoryEN:
          KTestText.discountModelItems.last.category.getTrsnslation(
        isEnglish: false,
      ),
      DiscountModelJsonField.company: KTestText.discountModelItems.last.company,
      DiscountModelJsonField.dateVerified:
          KTestText.discountModelItems.last.dateVerified.toIso8601String(),
      DiscountModelJsonField.description:
          KTestText.discountModelItems.last.description,
      DiscountModelJsonField.directLink:
          KTestText.discountModelItems.last.directLink,
      DiscountModelJsonField.discount:
          KTestText.discountModelItems.last.discount,
      // DiscountModelJsonField.eligibility:
      //     KTestText.discountModelItems.last.eligibility,
      DiscountModelJsonField.exclusions:
          KTestText.discountModelItems.last.exclusions,
      DiscountModelJsonField.expiration:
          KTestText.discountModelItems.last.expiration,
      // DiscountModelJsonField.html: KTestText.discountModelItems.last.html,
      DiscountModelJsonField.link: KTestText.discountModelItems.last.link,
      DiscountModelJsonField.location:
          KTestText.discountModelItems.last.location,
      DiscountModelJsonField.phoneNumber:
          KTestText.discountModelItems.last.phoneNumber,
      DiscountModelJsonField.requirements:
          KTestText.discountModelItems.last.requirements,
      DiscountModelJsonField.subLocation:
          KTestText.discountModelItems.last.subLocation,
      DiscountModelJsonField.subcategory:
          KTestText.discountModelItems.last.subcategory,
      DiscountModelJsonField.subcategoryEN: KTestText
          .discountModelItems.last.subcategory
          ?.getTrsnslation(isEnglish: false),
      DiscountModelJsonField.territory:
          KTestText.discountModelItems.last.territory,
      DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
      DiscountModelJsonField.userName:
          KTestText.discountModelItems.last.userName,
      DiscountModelJsonField.titleEN:
          KTestText.discountModelItems.last.title.uk,
      DiscountModelJsonField.locationEN: KTestText
          .discountModelItems.last.location
          ?.getTrsnslation(isEnglish: false),
      DiscountModelJsonField.territoryEN:
          KTestText.discountModelItems.last.territory?.uk,
      DiscountModelJsonField.exclusionsEN:
          KTestText.discountModelItems.last.exclusions?.uk,
      DiscountModelJsonField.expirationEN:
          KTestText.discountModelItems.last.expiration?.uk,
      DiscountModelJsonField.descriptionEN:
          KTestText.discountModelItems.last.description.uk,
      // DiscountModelJsonField.eligibilityEN:
      //     KTestText.discountModelItems.last.eligibilityEN,
      DiscountModelJsonField.requirementsEN:
          KTestText.discountModelItems.last.requirements?.uk,
      DiscountModelJsonField.companyEN:
          KTestText.discountModelItems.last.company?.uk,
      DiscountModelJsonField.additionalDetailsEN:
          KTestText.discountModelItems.last.additionalDetails?.uk,
      DiscountModelJsonField.userPhoto: [
        KTestText.discountModelItems.last.userPhoto!.toJson(),
      ],
      DiscountModelJsonField.status:
          KTestText.discountModelItems.last.status.enumString,
      DiscountModelJsonField.eligibility:
          KTestText.discountModelItems.last.eligibility,
      DiscountModelJsonField.eligibilityEN: KTestText
          .discountModelItems.last.eligibility
          ?.getTrsnslation(isEnglish: false),
      // DiscountModelJsonField.hasMarkdown:
      //     KTestText.discountModelItems.last.hasMarkdown,
      // DiscountModelJsonField.date:
      //     KTestText.discountModelItems.last.date.toIso8601String(),
    };
    final nullableJson = {
      DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
      DiscountModelJsonField.userId: null,
      DiscountModelJsonField.category:
          KTestText.discountModelItems.last.category,
      DiscountModelJsonField.categoryEN: null,
      DiscountModelJsonField.company: null,
      DiscountModelJsonField.dateVerified:
          KTestText.discountModelItems.last.dateVerified.toIso8601String(),
      DiscountModelJsonField.description:
          KTestText.discountModelItems.last.description,
      DiscountModelJsonField.link: KTestText.discountModelItems.last.link,
      DiscountModelJsonField.discount:
          KTestText.discountModelItems.last.discount,
      // DiscountModelJsonField.eligibility:
      //     KTestText.discountModelItems.last.eligibility,
      DiscountModelJsonField.exclusions: null,
      DiscountModelJsonField.expiration: null,
      DiscountModelJsonField.phoneNumber: null,
      DiscountModelJsonField.requirements: null,
      DiscountModelJsonField.subcategory: null,
      DiscountModelJsonField.subcategoryEN: null,
      DiscountModelJsonField.territory:
          KTestText.discountModelItems.last.territory,
      DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
      DiscountModelJsonField.titleEN: null,
      DiscountModelJsonField.territoryEN: null,
      DiscountModelJsonField.exclusionsEN: null,
      DiscountModelJsonField.descriptionEN: null,
      // DiscountModelJsonField.eligibilityEN:
      //     KTestText.discountModelItems.last.eligibilityEN,
      DiscountModelJsonField.requirementsEN: null,
      DiscountModelJsonField.expirationEN: null,
      DiscountModelJsonField.locationEN: null,
      // DiscountModelJsonField.hasMarkdown:
      //     KTestText.discountModelItems.last.hasMarkdown,
      DiscountModelJsonField.userPhoto: null,
      DiscountModelJsonField.subLocation: null,
      DiscountModelJsonField.location: null,
      // DiscountModelJsonField.date:
      //     KTestText.discountModelItems.last.date.toIso8601String(),
      DiscountModelJsonField.directLink: null,
      // DiscountModelJsonField.html: null,
      DiscountModelJsonField.additionalDetails: null,
      DiscountModelJsonField.userName: null,
      DiscountModelJsonField.additionalDetailsEN: null,
      DiscountModelJsonField.companyEN: null,
      DiscountModelJsonField.status: null,
      DiscountModelJsonField.eligibility: null,
      DiscountModelJsonField.eligibilityEN: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final discountModel = DiscountModel.fromJson(fullJson);

        expect(
          discountModel.id,
          KTestText.discountModelItems.last.id,
        );
        expect(
          discountModel.title,
          KTestText.discountModelItems.last.title,
        );
        expect(
          discountModel.userId,
          KTestText.discountModelItems.last.userId,
        );
        expect(
          discountModel.additionalDetails,
          KTestText.discountModelItems.last.additionalDetails,
        );
        expect(
          discountModel.category,
          KTestText.discountModelItems.last.category,
        );
        // expect(
        //   discountModel.categoryEN,
        //   KTestText.discountModelItems.last.categoryEN,
        // );
        expect(
          discountModel.company,
          KTestText.discountModelItems.last.company,
        );
        expect(
          discountModel.dateVerified,
          KTestText.discountModelItems.last.dateVerified,
        );
        expect(
          discountModel.description,
          KTestText.discountModelItems.last.description,
        );
        expect(
          discountModel.directLink,
          KTestText.discountModelItems.last.directLink,
        );
        expect(
          discountModel.discount,
          KTestText.discountModelItems.last.discount,
        );
        // expect(
        //   discountModel.eligibility,
        //   KTestText.discountModelItems.last.eligibility,
        // );
        expect(
          discountModel.exclusions,
          KTestText.discountModelItems.last.exclusions,
        );
        expect(
          discountModel.expiration,
          KTestText.discountModelItems.last.expiration,
        );
        // expect(
        //   discountModel.html,
        //   KTestText.discountModelItems.last.html,
        // );
        expect(
          discountModel.link,
          KTestText.discountModelItems.last.link,
        );
        expect(
          discountModel.location,
          KTestText.discountModelItems.last.location,
        );
        expect(
          discountModel.phoneNumber,
          KTestText.discountModelItems.last.phoneNumber,
        );
        expect(
          discountModel.requirements,
          KTestText.discountModelItems.last.requirements,
        );
        expect(
          discountModel.subLocation,
          KTestText.discountModelItems.last.subLocation,
        );
        expect(
          discountModel.subcategory,
          KTestText.discountModelItems.last.subcategory,
        );
        // expect(
        //   discountModel.subcategoryEN,
        //   KTestText.discountModelItems.last.subcategoryEN,
        // );
        expect(
          discountModel.territory,
          KTestText.discountModelItems.last.territory,
        );
        expect(
          discountModel.userName,
          KTestText.discountModelItems.last.userName,
        );
        expect(
          discountModel.userPhoto,
          KTestText.discountModelItems.last.userPhoto,
        );
        // expect(
        //   discountModel.titleEN,
        //   KTestText.discountModelItems.last.titleEN,
        // );
        // expect(
        //   discountModel.locationEN,
        //   KTestText.discountModelItems.last.locationEN,
        // );
        // expect(
        //   discountModel.territoryEN,
        //   KTestText.discountModelItems.last.territoryEN,
        // );
        // expect(
        //   discountModel.exclusionsEN,
        //   KTestText.discountModelItems.last.exclusionsEN,
        // );
        // expect(
        //   discountModel.expirationEN,
        //   KTestText.discountModelItems.last.expirationEN,
        // );
        // expect(
        //   discountModel.descriptionEN,
        //   KTestText.discountModelItems.last.descriptionEN,
        // );
        // expect(
        //   discountModel.companyEN,
        //   KTestText.discountModelItems.last.companyEN,
        // );
        // expect(
        //   discountModel.eligibilityEN,
        //   KTestText.discountModelItems.last.eligibilityEN,
        // );
        // expect(
        //   discountModel.requirementsEN,
        //   KTestText.discountModelItems.last.requirementsEN,
        // );
        expect(
          discountModel.status,
          KTestText.discountModelItems.last.status,
        );
        expect(
          discountModel.eligibility,
          KTestText.discountModelItems.last.eligibility,
        );
        // expect(
        //   discountModel.eligibilityEN,
        //   KTestText.discountModelItems.last.eligibilityEN,
        // );
        // expect(
        //   discountModel.date,
        //   KTestText.discountModelItems.last.date,
        // );
      });

      test('${KGroupText.nullable} ', () {
        final discountModel = DiscountModel.fromJson(nullableJson);

        expect(
          discountModel.id,
          KTestText.discountModelItems.last.id,
        );
        expect(
          discountModel.title,
          KTestText.discountModelItems.last.title,
        );
        expect(
          discountModel.userId,
          null,
        );
        expect(
          discountModel.additionalDetails,
          null,
        );
        expect(
          discountModel.category,
          KTestText.discountModelItems.last.category,
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
          KTestText.discountModelItems.last.dateVerified,
        );
        expect(
          discountModel.description,
          KTestText.discountModelItems.last.description,
        );
        expect(
          discountModel.link,
          KTestText.discountModelItems.last.link,
        );
        expect(
          discountModel.discount,
          KTestText.discountModelItems.last.discount,
        );
        // expect(
        //   discountModel.eligibility,
        //   KTestText.discountModelItems.last.eligibility,
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
        expect(
          discountModel.subcategory,
          null,
        );
        // expect(
        //   discountModel.subcategoryEN,
        //   null,
        // );
        expect(
          discountModel.territory,
          KTestText.discountModelItems.last.territory,
        );
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
        //   KTestText.discountModelItems.last.eligibilityEN,
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
        //   KTestText.discountModelItems.last.date,
        // );
      });

      test('${KGroupText.failure} ', () {
        // title is missing
        final json = {
          DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
          // title is missing
          DiscountModelJsonField.userId:
              KTestText.discountModelItems.last.userId,
          DiscountModelJsonField.userName:
              KTestText.discountModelItems.last.userName,
          DiscountModelJsonField.additionalDetails:
              KTestText.discountModelItems.last.additionalDetails,
          DiscountModelJsonField.category:
              KTestText.discountModelItems.last.category,
          DiscountModelJsonField.categoryEN: KTestText
              .discountModelItems.last.category
              .getTrsnslation(isEnglish: false),
          DiscountModelJsonField.company:
              KTestText.discountModelItems.last.company,
          DiscountModelJsonField.dateVerified:
              KTestText.discountModelItems.last.dateVerified.toIso8601String(),
          DiscountModelJsonField.description:
              KTestText.discountModelItems.last.description,
          DiscountModelJsonField.directLink:
              KTestText.discountModelItems.last.directLink,
          DiscountModelJsonField.discount:
              KTestText.discountModelItems.last.discount,
          // DiscountModelJsonField.eligibility:
          //     KTestText.discountModelItems.last.eligibility,
          DiscountModelJsonField.exclusions:
              KTestText.discountModelItems.last.exclusions,
          DiscountModelJsonField.expiration:
              KTestText.discountModelItems.last.expiration,
          // DiscountModelJsonField.html: KTestText.discountModelItems.last
          // .html,
          DiscountModelJsonField.link: KTestText.discountModelItems.last.link,
          DiscountModelJsonField.location:
              KTestText.discountModelItems.last.location,
          DiscountModelJsonField.phoneNumber:
              KTestText.discountModelItems.last.phoneNumber,
          DiscountModelJsonField.requirements:
              KTestText.discountModelItems.last.requirements,
          DiscountModelJsonField.subLocation:
              KTestText.discountModelItems.last.subLocation,
          DiscountModelJsonField.subcategory:
              KTestText.discountModelItems.last.subcategory,
          DiscountModelJsonField.subcategoryEN: KTestText
              .discountModelItems.last.subcategory
              ?.getTrsnslation(isEnglish: false),
          DiscountModelJsonField.territory:
              KTestText.discountModelItems.last.territory,
          DiscountModelJsonField.titleEN:
              KTestText.discountModelItems.last.title.uk,
          DiscountModelJsonField.locationEN: KTestText
              .discountModelItems.last.location
              ?.getTrsnslation(isEnglish: false),
          DiscountModelJsonField.territoryEN:
              KTestText.discountModelItems.last.territory?.uk,
          DiscountModelJsonField.exclusionsEN:
              KTestText.discountModelItems.last.exclusions?.uk,
          DiscountModelJsonField.expirationEN:
              KTestText.discountModelItems.last.expiration?.uk,
          DiscountModelJsonField.descriptionEN:
              KTestText.discountModelItems.last.description.uk,
          // DiscountModelJsonField.eligibilityEN:
          //     KTestText.discountModelItems.last.eligibilityEN,
          DiscountModelJsonField.requirementsEN:
              KTestText.discountModelItems.last.requirements?.uk,
          DiscountModelJsonField.companyEN:
              KTestText.discountModelItems.last.company?.uk,
          // DiscountModelJsonField.date:
          //     KTestText.discountModelItems.last.date.toIso8601String(),
        };

        expect(
          () => DiscountModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final discountModelJson = KTestText.discountModelItems.last.toJson();

        expect(discountModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final discountModelJson = KTestText.discountModelItems.last
            .copyWith(
              directLink: null,
              additionalDetails: null,
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
              subcategory: null,
              exclusions: null,
              eligibility: null,
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
