import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} ${KGroupText.model} ', () {
    final fullJson = {
      DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
      DiscountModelJsonField.userId: KTestText.discountModelItems.last.userId,
      DiscountModelJsonField.additionalDetails:
          KTestText.discountModelItems.last.additionalDetails,
      DiscountModelJsonField.category:
          KTestText.discountModelItems.last.category,
      DiscountModelJsonField.categoryUA:
          KTestText.discountModelItems.last.categoryUA,
      DiscountModelJsonField.company: KTestText.discountModelItems.last.company,
      DiscountModelJsonField.dateVerified:
          KTestText.discountModelItems.last.dateVerified.toIso8601String(),
      DiscountModelJsonField.description:
          KTestText.discountModelItems.last.description,
      DiscountModelJsonField.directLink:
          KTestText.discountModelItems.last.directLink,
      DiscountModelJsonField.discount:
          KTestText.discountModelItems.last.discount,
      DiscountModelJsonField.eligibility:
          KTestText.discountModelItems.last.eligibility,
      DiscountModelJsonField.exclusions:
          KTestText.discountModelItems.last.exclusions,
      DiscountModelJsonField.expiration:
          KTestText.discountModelItems.last.expiration,
      DiscountModelJsonField.html: KTestText.discountModelItems.last.html,
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
      DiscountModelJsonField.subcategoryUA:
          KTestText.discountModelItems.last.subcategoryUA,
      DiscountModelJsonField.territory:
          KTestText.discountModelItems.last.territory,
      DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
      DiscountModelJsonField.userName:
          KTestText.discountModelItems.last.userName,
      DiscountModelJsonField.userPhoto: [
        KTestText.discountModelItems.last.userPhoto!.toJson(),
      ],
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
      DiscountModelJsonField.categoryUA:
          KTestText.discountModelItems.last.categoryUA,
      DiscountModelJsonField.company: null,
      DiscountModelJsonField.dateVerified:
          KTestText.discountModelItems.last.dateVerified.toIso8601String(),
      DiscountModelJsonField.description:
          KTestText.discountModelItems.last.description,
      DiscountModelJsonField.link: KTestText.discountModelItems.last.link,
      DiscountModelJsonField.discount:
          KTestText.discountModelItems.last.discount,
      DiscountModelJsonField.eligibility:
          KTestText.discountModelItems.last.eligibility,
      DiscountModelJsonField.exclusions:
          KTestText.discountModelItems.last.exclusions,
      DiscountModelJsonField.expiration:
          KTestText.discountModelItems.last.expiration,
      DiscountModelJsonField.phoneNumber:
          KTestText.discountModelItems.last.phoneNumber,
      DiscountModelJsonField.requirements:
          KTestText.discountModelItems.last.requirements,
      DiscountModelJsonField.subcategory:
          KTestText.discountModelItems.last.subcategory,
      DiscountModelJsonField.subcategoryUA:
          KTestText.discountModelItems.last.subcategoryUA,
      DiscountModelJsonField.territory:
          KTestText.discountModelItems.last.territory,
      DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
      // DiscountModelJsonField.hasMarkdown:
      //     KTestText.discountModelItems.last.hasMarkdown,
      DiscountModelJsonField.userPhoto: null,
      DiscountModelJsonField.subLocation: null,
      DiscountModelJsonField.location: null,
      // DiscountModelJsonField.date:
      //     KTestText.discountModelItems.last.date.toIso8601String(),
      DiscountModelJsonField.directLink: null,
      DiscountModelJsonField.html: null,
      DiscountModelJsonField.additionalDetails: null,
      DiscountModelJsonField.userName: null,
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
        expect(
          discountModel.categoryUA,
          KTestText.discountModelItems.last.categoryUA,
        );
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
        expect(
          discountModel.eligibility,
          KTestText.discountModelItems.last.eligibility,
        );
        expect(
          discountModel.exclusions,
          KTestText.discountModelItems.last.exclusions,
        );
        expect(
          discountModel.expiration,
          KTestText.discountModelItems.last.expiration,
        );
        expect(
          discountModel.html,
          KTestText.discountModelItems.last.html,
        );
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
        expect(
          discountModel.subcategoryUA,
          KTestText.discountModelItems.last.subcategoryUA,
        );
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
        expect(
          discountModel.categoryUA,
          KTestText.discountModelItems.last.categoryUA,
        );
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
        expect(
          discountModel.eligibility,
          KTestText.discountModelItems.last.eligibility,
        );
        expect(
          discountModel.exclusions,
          KTestText.discountModelItems.last.exclusions,
        );
        expect(
          discountModel.expiration,
          KTestText.discountModelItems.last.expiration,
        );
        expect(
          discountModel.html,
          null,
        );
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
          KTestText.discountModelItems.last.phoneNumber,
        );
        expect(
          discountModel.requirements,
          KTestText.discountModelItems.last.requirements,
        );
        expect(
          discountModel.subLocation,
          null,
        );
        expect(
          discountModel.subcategory,
          KTestText.discountModelItems.last.subcategory,
        );
        expect(
          discountModel.subcategoryUA,
          KTestText.discountModelItems.last.subcategoryUA,
        );
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
          DiscountModelJsonField.categoryUA:
              KTestText.discountModelItems.last.categoryUA,
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
          DiscountModelJsonField.eligibility:
              KTestText.discountModelItems.last.eligibility,
          DiscountModelJsonField.exclusions:
              KTestText.discountModelItems.last.exclusions,
          DiscountModelJsonField.expiration:
              KTestText.discountModelItems.last.expiration,
          DiscountModelJsonField.html: KTestText.discountModelItems.last.html,
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
          DiscountModelJsonField.subcategoryUA:
              KTestText.discountModelItems.last.subcategoryUA,
          DiscountModelJsonField.territory:
              KTestText.discountModelItems.last.territory,
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
              html: null,
              userId: null,
              userName: null,
              company: null,
              location: null,
              subLocation: null,
              userPhoto: null,
            )
            .toJson();

        expect(discountModelJson, nullableJson);
      });
    });
  });
}
