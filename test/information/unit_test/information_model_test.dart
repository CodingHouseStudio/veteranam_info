import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.information} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.informationModelItems.last.id,
          'title': KTestText.informationModelItems.last.title,
          'news': KTestText.informationModelItems.last.news,
          'date': KTestText.informationModelItems.last.date.toIso8601String(),
          'tags': KTestText.informationModelItems.last.tags,
          'image': [KTestText.informationModelItems.last.image!.first.toJson()],
        };

        final informationModel = InformationModel.fromJson(json);

        expect(
          informationModel.id,
          KTestText.informationModelItems.last.id,
        );
        expect(
          informationModel.title,
          KTestText.informationModelItems.last.title,
        );
        expect(
          informationModel.news,
          KTestText.informationModelItems.last.news,
        );
        expect(
          informationModel.date,
          KTestText.informationModelItems.last.date,
        );
        expect(
          informationModel.image,
          KTestText.informationModelItems.last.image,
        );
        expect(
          informationModel.tags,
          KTestText.informationModelItems.last.tags,
        );
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.informationModelItems.last.id,
          'title': KTestText.informationModelItems.last.title,
          'news': KTestText.informationModelItems.last.news,
          'date': KTestText.informationModelItems.last.date.toIso8601String(),
        };

        final informationModel = InformationModel.fromJson(json);

        expect(
          informationModel.id,
          KTestText.informationModelItems.last.id,
        );
        expect(
          informationModel.title,
          KTestText.informationModelItems.last.title,
        );
        expect(
          informationModel.news,
          KTestText.informationModelItems.last.news,
        );
        expect(
          informationModel.date,
          KTestText.informationModelItems.last.date,
        );
        expect(
          informationModel.image,
          null,
        );
        expect(
          informationModel.tags,
          <String>[],
        );
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          'id': KTestText.informationModelItems.last.id,
          // title is missing
          'news': KTestText.informationModelItems.last.news,
          'date': KTestText.informationModelItems.last.date.toIso8601String(),
        };

        expect(
          () => InformationModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.informationModelItems.last.id,
          'title': KTestText.informationModelItems.last.title,
          'news': KTestText.informationModelItems.last.news,
          'date': KTestText.informationModelItems.last.date.toIso8601String(),
          'tags': KTestText.informationModelItems.last.tags,
          'image': [KTestText.informationModelItems.last.image!.first.toJson()],
        };

        final informationModelJson =
            KTestText.informationModelItems.last.toJson();

        expect(informationModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.informationModelItems.last.id,
          'title': KTestText.informationModelItems.last.title,
          'news': KTestText.informationModelItems.last.news,
          'date': KTestText.informationModelItems.last.date.toIso8601String(),
          'tags': null,
          'image': null,
        };

        final informationModelJson = KTestText.informationModelItems.last
            .copyWith(tags: null, image: null)
            .toJson();

        expect(informationModelJson, json);
      });
    });
  });
}
