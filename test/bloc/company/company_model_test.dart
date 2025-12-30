import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/shared/models/models.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.company} ${KGroupText.model}', () {
    test('check is Empty ', () {
      expect(
        KTestVariables.fullCompanyModel.isEmpty,
        isFalse,
      );

      expect(
        KTestVariables.pureCompanyModel.isEmpty,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestVariables.fullCompanyModel.isNotEmpty,
        isTrue,
      );

      expect(
        KTestVariables.pureCompanyModel.isNotEmpty,
        isFalse,
      );
    });
    final fullJson = {
      CompanyModelJsonField.id: KTestVariables.fullCompanyModel.id,
      CompanyModelJsonField.companyName:
          KTestVariables.fullCompanyModel.companyName,
      CompanyModelJsonField.publicName:
          KTestVariables.fullCompanyModel.publicName,
      CompanyModelJsonField.link: KTestVariables.fullCompanyModel.link,
      CompanyModelJsonField.code: KTestVariables.fullCompanyModel.code,
      CompanyModelJsonField.image: [KTestVariables.imageModel.toJson()],
      CompanyModelJsonField.userEmails:
          KTestVariables.fullCompanyModel.userEmails,
      CompanyModelJsonField.deletedOn:
          KTestVariables.dateTime.toIso8601String(),
      // Subscription fields are null and included in JSON
      CompanyModelJsonField.stripeCustomerId: null,
      CompanyModelJsonField.stripeSubscriptionId: null,
      CompanyModelJsonField.subscriptionStatus: null,
      CompanyModelJsonField.subscriptionPlan: null,
      CompanyModelJsonField.trialStartedAt: null,
      CompanyModelJsonField.trialExpiresAt: null,
      CompanyModelJsonField.subscriptionStartedAt: null,
      CompanyModelJsonField.subscriptionExpiresAt: null,
      CompanyModelJsonField.termsAccepted: null,
      CompanyModelJsonField.termsAcceptedAt: null,
      CompanyModelJsonField.trialExtensionDays: null,
      CompanyModelJsonField.canceledBy: null,
      CompanyModelJsonField.canceledAt: null,
    };
    final nullableJson = {
      CompanyModelJsonField.id: KTestVariables.fullCompanyModel.id,
      CompanyModelJsonField.userEmails:
          KTestVariables.fullCompanyModel.userEmails,
      // All other fields are null and included in JSON
      CompanyModelJsonField.companyName: null,
      CompanyModelJsonField.publicName: null,
      CompanyModelJsonField.link: null,
      CompanyModelJsonField.code: null,
      CompanyModelJsonField.image: null,
      CompanyModelJsonField.deletedOn: null,
      CompanyModelJsonField.stripeCustomerId: null,
      CompanyModelJsonField.stripeSubscriptionId: null,
      CompanyModelJsonField.subscriptionStatus: null,
      CompanyModelJsonField.subscriptionPlan: null,
      CompanyModelJsonField.trialStartedAt: null,
      CompanyModelJsonField.trialExpiresAt: null,
      CompanyModelJsonField.subscriptionStartedAt: null,
      CompanyModelJsonField.subscriptionExpiresAt: null,
      CompanyModelJsonField.termsAccepted: null,
      CompanyModelJsonField.termsAcceptedAt: null,
      CompanyModelJsonField.trialExtensionDays: null,
      CompanyModelJsonField.canceledBy: null,
      CompanyModelJsonField.canceledAt: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final fullCompanyModel = CompanyModel.fromJson(fullJson);

        expect(fullCompanyModel.id, KTestVariables.fullCompanyModel.id);
        expect(
          fullCompanyModel.userEmails,
          KTestVariables.fullCompanyModel.userEmails,
        );
        expect(
          fullCompanyModel.companyName,
          KTestVariables.fullCompanyModel.companyName,
        );
        expect(
          fullCompanyModel.code,
          KTestVariables.fullCompanyModel.code,
        );
        expect(
          fullCompanyModel.publicName,
          KTestVariables.fullCompanyModel.publicName,
        );
        expect(fullCompanyModel.link, KTestVariables.fullCompanyModel.link);
        expect(fullCompanyModel.image, KTestVariables.imageModel);
        expect(fullCompanyModel.deletedOn, KTestVariables.dateTime);
      });
      test('${KGroupText.nullable} ', () {
        final fullCompanyModel = CompanyModel.fromJson(nullableJson);

        expect(fullCompanyModel.id, KTestVariables.fullCompanyModel.id);
        expect(
          fullCompanyModel.userEmails,
          KTestVariables.fullCompanyModel.userEmails,
        );
        expect(
          null,
          isNull,
        );
        expect(fullCompanyModel.companyName, isNull);
        expect(fullCompanyModel.publicName, isNull);
        expect(fullCompanyModel.image, isNull);
        expect(fullCompanyModel.link, isNull);
        expect(fullCompanyModel.image, isNull);
        expect(fullCompanyModel.code, isNull);
        expect(fullCompanyModel.deletedOn, isNull);
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          CompanyModelJsonField.companyName:
              KTestVariables.fullCompanyModel.companyName,
          CompanyModelJsonField.publicName:
              KTestVariables.fullCompanyModel.publicName,
          CompanyModelJsonField.link: KTestVariables.fullCompanyModel.link,
          CompanyModelJsonField.image: KTestVariables.fullCompanyModel.image,
          CompanyModelJsonField.userEmails:
              KTestVariables.fullCompanyModel.userEmails,
          CompanyModelJsonField.code: KTestVariables.fullCompanyModel.code,
        };

        expect(
          () => CompanyModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final fullCompanyModelModelJson = KTestVariables.fullCompanyModel
            .copyWith(
              image: KTestVariables.imageModel,
              deletedOn: KTestVariables.dateTime,
            )
            .toJson();

        expect(fullCompanyModelModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final pureCompanyModelModelJson = CompanyModel(
          id: KTestVariables.fullCompanyModel.id,
          userEmails: KTestVariables.fullCompanyModel.userEmails,
        ).toJson();

        expect(pureCompanyModelModelJson, nullableJson);
      });
    });
  });
}
