import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.investors} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          FundModelJsonField.id: KTestText.fundItems.last.id,
          FundModelJsonField.title: KTestText.fundItems.last.title,
          FundModelJsonField.subtitle: KTestText.fundItems.last.subtitle,
          FundModelJsonField.link: KTestText.fundItems.last.link,
          FundModelJsonField.image: KTestText.fundItems.last.image,
        };

        final fundModel = FundModel.fromJson(json);

        expect(fundModel.id, KTestText.fundItems.last.id);
        expect(
          fundModel.title,
          KTestText.fundItems.last.title,
        );
        expect(
          fundModel.subtitle,
          KTestText.fundItems.last.subtitle,
        );
        expect(
          fundModel.link,
          KTestText.fundItems.last.link,
        );
        expect(
          fundModel.image,
          KTestText.fundItems.last.image,
        );
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          FundModelJsonField.id: KTestText.fundItems.last.id,
          FundModelJsonField.title: KTestText.fundItems.last.title,
          FundModelJsonField.subtitle: KTestText.fundItems.last.subtitle,
          FundModelJsonField.link: KTestText.fundItems.last.link,
        };

        final fundModel = FundModel.fromJson(json);

        expect(fundModel.id, KTestText.fundItems.last.id);
        expect(
          fundModel.title,
          KTestText.fundItems.last.title,
        );
        expect(
          fundModel.subtitle,
          KTestText.fundItems.last.subtitle,
        );
        expect(
          fundModel.link,
          KTestText.fundItems.last.link,
        );
        expect(
          fundModel.image,
          null,
        );
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          FundModelJsonField.id: KTestText.fundItems.last.id,
          // title is missing
          FundModelJsonField.subtitle: KTestText.fundItems.last.subtitle,
          FundModelJsonField.link: KTestText.fundItems.last.link,
          FundModelJsonField.image: KTestText.fundItems.last.image,
        };

        expect(
          () => FundModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          FundModelJsonField.id: KTestText.fundItems.last.id,
          FundModelJsonField.title: KTestText.fundItems.last.title,
          FundModelJsonField.subtitle: KTestText.fundItems.last.subtitle,
          FundModelJsonField.link: KTestText.fundItems.last.link,
          FundModelJsonField.image: KTestText.fundItems.last.image,
        };

        final fundModelJson = KTestText.fundItems.last.toJson();

        expect(fundModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          FundModelJsonField.id: KTestText.fundItems.last.id,
          FundModelJsonField.title: KTestText.fundItems.last.title,
          FundModelJsonField.subtitle: KTestText.fundItems.last.subtitle,
          FundModelJsonField.link: KTestText.fundItems.last.link,
          FundModelJsonField.image: null,
        };

        final fundModelJson =
            KTestText.fundItems.last.copyWith(image: null).toJson();

        expect(fundModelJson, json);
      });
    });
  });
}
