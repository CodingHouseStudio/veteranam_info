import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.investors} ${KGroupText.model} ', () {
    final fullJson = {
      FundModelJsonField.id: KTestText.fundItems.last.id,
      FundModelJsonField.title: KTestText.fundItems.last.title,
      FundModelJsonField.description: KTestText.fundItems.last.description,
      FundModelJsonField.titleEN: KTestText.fundItems.last.titleEN,
      FundModelJsonField.descriptionEN: KTestText.fundItems.last.descriptionEN,
      FundModelJsonField.link: KTestText.fundItems.last.link,
      FundModelJsonField.image: KTestText.fundItems.last.image,
      // FundModelJsonField.comments: KTestText.fundItems.last.comments,
      // FundModelJsonField.domain: KTestText.fundItems.last.domain,
      // FundModelJsonField.email: KTestText.fundItems.last.email,
      // FundModelJsonField.phoneNumber: KTestText.fundItems.last.phoneNumber,
      FundModelJsonField.projectsLink: KTestText.fundItems.last.projectsLink,
      // FundModelJsonField.registered: KTestText.fundItems.last.registered,
      // FundModelJsonField.size: KTestText.fundItems.last.size,
      // FundModelJsonField.teamPartnersLink:
      //     KTestText.fundItems.last.teamPartnersLink,
    };
    final nullableJson = {
      FundModelJsonField.id: KTestText.fundItems.last.id,
      FundModelJsonField.title: KTestText.fundItems.last.title,
      FundModelJsonField.description: KTestText.fundItems.last.description,
      FundModelJsonField.link: KTestText.fundItems.last.link,
      FundModelJsonField.titleEN: KTestText.fundItems.last.titleEN,
      FundModelJsonField.descriptionEN: KTestText.fundItems.last.descriptionEN,
      FundModelJsonField.image: null,
      // FundModelJsonField.comments: null,
      // FundModelJsonField.domain: KTestText.fundItems.last.domain,
      // FundModelJsonField.email: null,
      // FundModelJsonField.phoneNumber: null,
      FundModelJsonField.projectsLink: null,
      // FundModelJsonField.registered: null,
      // FundModelJsonField.size: null,
      // FundModelJsonField.teamPartnersLink: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final fundModel = FundModel.fromJson(fullJson);

        expect(fundModel.id, KTestText.fundItems.last.id);
        expect(
          fundModel.title,
          KTestText.fundItems.last.title,
        );
        expect(
          fundModel.description,
          KTestText.fundItems.last.description,
        );
        expect(
          fundModel.link,
          KTestText.fundItems.last.link,
        );
        expect(
          fundModel.image,
          KTestText.fundItems.last.image,
        );
        expect(
          fundModel.titleEN,
          KTestText.fundItems.last.titleEN,
        );
        expect(
          fundModel.descriptionEN,
          KTestText.fundItems.last.descriptionEN,
        );
        // expect(
        //   fundModel.comments,
        //   KTestText.fundItems.last.comments,
        // );
        // expect(
        //   fundModel.domain,
        //   KTestText.fundItems.last.domain,
        // );
        // expect(
        //   fundModel.email,
        //   KTestText.fundItems.last.email,
        // );
        // expect(
        //   fundModel.phoneNumber,
        //   KTestText.fundItems.last.phoneNumber,
        // );
        expect(
          fundModel.projectsLink,
          KTestText.fundItems.last.projectsLink,
        );
        // expect(
        //   fundModel.registered,
        //   KTestText.fundItems.last.registered,
        // );
        // expect(
        //   fundModel.size,
        //   KTestText.fundItems.last.size,
        // );
        // expect(
        //   fundModel.teamPartnersLink,
        //   KTestText.fundItems.last.teamPartnersLink,
        // );
      });

      test('${KGroupText.nullable} ', () {
        final fundModel = FundModel.fromJson(nullableJson);

        expect(fundModel.id, KTestText.fundItems.last.id);
        expect(
          fundModel.title,
          KTestText.fundItems.last.title,
        );
        expect(
          fundModel.description,
          KTestText.fundItems.last.description,
        );
        expect(
          fundModel.titleEN,
          KTestText.fundItems.last.titleEN,
        );
        expect(
          fundModel.descriptionEN,
          KTestText.fundItems.last.descriptionEN,
        );
        expect(
          fundModel.link,
          KTestText.fundItems.last.link,
        );
        expect(
          fundModel.image,
          null,
        );
        // expect(
        //   fundModel.comments,
        //   null,
        // );
        // expect(
        //   fundModel.domain,
        //   KTestText.fundItems.last.domain,
        // );
        // expect(
        //   fundModel.email,
        //   null,
        // );
        // expect(
        //   fundModel.phoneNumber,
        //   null,
        // );
        expect(
          fundModel.projectsLink,
          null,
        );
        // expect(
        //   fundModel.registered,
        //   null,
        // );
        // expect(
        //   fundModel.size,
        //   null,
        // );
        // expect(
        //   fundModel.teamPartnersLink,
        //   null,
        // );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          FundModelJsonField.id: KTestText.fundItems.last.id,
          // title is missing
          FundModelJsonField.description: KTestText.fundItems.last.description,
          FundModelJsonField.link: KTestText.fundItems.last.link,
          FundModelJsonField.image: KTestText.fundItems.last.image,
          FundModelJsonField.titleEN: KTestText.fundItems.last.titleEN,
          FundModelJsonField.descriptionEN:
              KTestText.fundItems.last.descriptionEN,
          // FundModelJsonField.comments: KTestText.fundItems.last.comments,
          // FundModelJsonField.domain: KTestText.fundItems.last.domain,
          // FundModelJsonField.email: KTestText.fundItems.last.email,
          // FundModelJsonField.phoneNumber: KTestText.fundItems.last.
          // phoneNumber,
          FundModelJsonField.projectsLink:
              KTestText.fundItems.last.projectsLink,
          // FundModelJsonField.registered: KTestText.fundItems.last.registered,
          // FundModelJsonField.size: KTestText.fundItems.last.size,
          // FundModelJsonField.teamPartnersLink:
          //     KTestText.fundItems.last.teamPartnersLink,
        };

        expect(
          () => FundModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final fundModelJson = KTestText.fundItems.last.toJson();

        expect(fundModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final fundModelJson = KTestText.fundItems.last
            .copyWith(
              projectsLink: null,
              image: null,
            )
            .toJson();

        expect(fundModelJson, nullableJson);
      });
    });
  });
}
