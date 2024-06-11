import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/models/models.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
          DiscountModelJsonField.userId:
              KTestText.discountModelItems.last.userId,
          DiscountModelJsonField.additionaldetails:
              KTestText.discountModelItems.last.additionaldetails,
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
          DiscountModelJsonField.selectedLocationsOnly:
              KTestText.discountModelItems.last.selectedLocationsOnly,
          DiscountModelJsonField.subcategory:
              KTestText.discountModelItems.last.subcategory,
          DiscountModelJsonField.subcategoryUA:
              KTestText.discountModelItems.last.subcategoryUA,
          DiscountModelJsonField.territory:
              KTestText.discountModelItems.last.territory,
          DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
        };

        final discountModel = DiscountModel.fromJson(json);

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
          discountModel.additionaldetails,
          KTestText.discountModelItems.last.additionaldetails,
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
          discountModel.selectedLocationsOnly,
          KTestText.discountModelItems.last.selectedLocationsOnly,
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
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
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
          DiscountModelJsonField.location:
              KTestText.discountModelItems.last.location,
          DiscountModelJsonField.phoneNumber:
              KTestText.discountModelItems.last.phoneNumber,
          DiscountModelJsonField.requirements:
              KTestText.discountModelItems.last.requirements,
          DiscountModelJsonField.selectedLocationsOnly:
              KTestText.discountModelItems.last.selectedLocationsOnly,
          DiscountModelJsonField.subcategory:
              KTestText.discountModelItems.last.subcategory,
          DiscountModelJsonField.subcategoryUA:
              KTestText.discountModelItems.last.subcategoryUA,
          DiscountModelJsonField.territory:
              KTestText.discountModelItems.last.territory,
          DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
        };

        final discountModel = DiscountModel.fromJson(json);

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
          discountModel.additionaldetails,
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
          null,
        );
        expect(
          discountModel.link,
          null,
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
          discountModel.selectedLocationsOnly,
          KTestText.discountModelItems.last.selectedLocationsOnly,
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
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
          // title is missing
          DiscountModelJsonField.userId:
              KTestText.discountModelItems.last.userId,
          DiscountModelJsonField.additionaldetails:
              KTestText.discountModelItems.last.additionaldetails,
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
          DiscountModelJsonField.selectedLocationsOnly:
              KTestText.discountModelItems.last.selectedLocationsOnly,
          DiscountModelJsonField.subcategory:
              KTestText.discountModelItems.last.subcategory,
          DiscountModelJsonField.subcategoryUA:
              KTestText.discountModelItems.last.subcategoryUA,
          DiscountModelJsonField.territory:
              KTestText.discountModelItems.last.territory,
        };

        expect(
          () => DiscountModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
          DiscountModelJsonField.userId:
              KTestText.discountModelItems.last.userId,
          DiscountModelJsonField.additionaldetails:
              KTestText.discountModelItems.last.additionaldetails,
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
          DiscountModelJsonField.selectedLocationsOnly:
              KTestText.discountModelItems.last.selectedLocationsOnly,
          DiscountModelJsonField.subcategory:
              KTestText.discountModelItems.last.subcategory,
          DiscountModelJsonField.subcategoryUA:
              KTestText.discountModelItems.last.subcategoryUA,
          DiscountModelJsonField.territory:
              KTestText.discountModelItems.last.territory,
          DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
        };

        final discountModelJson = KTestText.discountModelItems.last.toJson();

        expect(discountModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          DiscountModelJsonField.id: KTestText.discountModelItems.last.id,
          DiscountModelJsonField.userId: null,
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
          DiscountModelJsonField.location:
              KTestText.discountModelItems.last.location,
          DiscountModelJsonField.phoneNumber:
              KTestText.discountModelItems.last.phoneNumber,
          DiscountModelJsonField.requirements:
              KTestText.discountModelItems.last.requirements,
          DiscountModelJsonField.selectedLocationsOnly:
              KTestText.discountModelItems.last.selectedLocationsOnly,
          DiscountModelJsonField.subcategory:
              KTestText.discountModelItems.last.subcategory,
          DiscountModelJsonField.subcategoryUA:
              KTestText.discountModelItems.last.subcategoryUA,
          DiscountModelJsonField.territory:
              KTestText.discountModelItems.last.territory,
          DiscountModelJsonField.title: KTestText.discountModelItems.last.title,
          DiscountModelJsonField.link: null,
          DiscountModelJsonField.html: null,
          DiscountModelJsonField.additionaldetails: null,
        };

        final discountModelJson = KTestText.discountModelItems.last
            .copyWith(
              link: null,
              additionaldetails: null,
              html: null,
              userId: null,
            )
            .toJson();

        expect(discountModelJson, json);
      });
    });
  });
}
