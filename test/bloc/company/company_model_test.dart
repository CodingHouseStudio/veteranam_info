import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.company} ${KGroupText.model}', () {
    test('check is Empty ', () {
      expect(
        KTestText.fullCompanyModel.isEmpty,
        isFalse,
      );

      expect(
        KTestText.pureCompanyModel.isEmpty,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestText.fullCompanyModel.isNotEmpty,
        isTrue,
      );

      expect(
        KTestText.pureCompanyModel.isNotEmpty,
        isFalse,
      );
    });
    final fullJson = {
      CompanyModelJsonField.id: KTestText.fullCompanyModel.id,
      CompanyModelJsonField.companyName: KTestText.fullCompanyModel.companyName,
      CompanyModelJsonField.publicName: KTestText.fullCompanyModel.publicName,
      CompanyModelJsonField.link: KTestText.fullCompanyModel.link,
      CompanyModelJsonField.code: KTestText.fullCompanyModel.code,
      CompanyModelJsonField.image: [KTestText.imageModel.toJson()],
      CompanyModelJsonField.userEmails: KTestText.fullCompanyModel.userEmails,
      CompanyModelJsonField.deletedOn: KTestText.dateTime.toIso8601String(),
    };
    final nullableJson = {
      CompanyModelJsonField.id: KTestText.fullCompanyModel.id,
      CompanyModelJsonField.companyName: null,
      CompanyModelJsonField.publicName: null,
      CompanyModelJsonField.link: null,
      CompanyModelJsonField.image: null,
      CompanyModelJsonField.code: null,
      CompanyModelJsonField.userEmails: KTestText.fullCompanyModel.userEmails,
      CompanyModelJsonField.deletedOn: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final fullCompanyModel = CompanyModel.fromJson(fullJson);

        expect(fullCompanyModel.id, KTestText.fullCompanyModel.id);
        expect(
          fullCompanyModel.userEmails,
          KTestText.fullCompanyModel.userEmails,
        );
        expect(
          fullCompanyModel.companyName,
          KTestText.fullCompanyModel.companyName,
        );
        expect(
          fullCompanyModel.code,
          KTestText.fullCompanyModel.code,
        );
        expect(
          fullCompanyModel.publicName,
          KTestText.fullCompanyModel.publicName,
        );
        expect(fullCompanyModel.link, KTestText.fullCompanyModel.link);
        expect(fullCompanyModel.image, KTestText.imageModel);
        expect(fullCompanyModel.deletedOn, KTestText.dateTime);
      });
      test('${KGroupText.nullable} ', () {
        final fullCompanyModel = CompanyModel.fromJson(nullableJson);

        expect(fullCompanyModel.id, KTestText.fullCompanyModel.id);
        expect(
          fullCompanyModel.userEmails,
          KTestText.fullCompanyModel.userEmails,
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
              KTestText.fullCompanyModel.companyName,
          CompanyModelJsonField.publicName:
              KTestText.fullCompanyModel.publicName,
          CompanyModelJsonField.link: KTestText.fullCompanyModel.link,
          CompanyModelJsonField.image: KTestText.fullCompanyModel.image,
          CompanyModelJsonField.userEmails:
              KTestText.fullCompanyModel.userEmails,
          CompanyModelJsonField.code: KTestText.fullCompanyModel.code,
        };

        expect(
          () => CompanyModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final fullCompanyModelModelJson = KTestText.fullCompanyModel
            .copyWith(
              image: KTestText.imageModel,
              deletedOn: KTestText.dateTime,
            )
            .toJson();

        expect(fullCompanyModelModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final pureCompanyModelModelJson = CompanyModel(
          id: KTestText.fullCompanyModel.id,
          userEmails: KTestText.fullCompanyModel.userEmails,
        ).toJson();

        expect(pureCompanyModelModelJson, nullableJson);
      });
    });
  });
}
