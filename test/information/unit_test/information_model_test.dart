import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/models/models.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.information} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          InformationModelJsonField.id: KTestText.informationModelItems.last.id,
          InformationModelJsonField.title:
              KTestText.informationModelItems.last.title,
          InformationModelJsonField.news:
              KTestText.informationModelItems.last.news,
          InformationModelJsonField.fetchDate:
              KTestText.informationModelItems.last.fetchDate.toIso8601String(),
          InformationModelJsonField.category:
              KTestText.informationModelItems.last.category,
          InformationModelJsonField.image: [
            KTestText.informationModelItems.last.image!.first.toJson(),
          ],
          InformationModelJsonField.categoryUA:
              KTestText.informationModelItems.last.categoryUA,
          InformationModelJsonField.topic:
              KTestText.informationModelItems.last.topic,
          InformationModelJsonField.topicUA:
              KTestText.informationModelItems.last.topicUA,
          InformationModelJsonField.status:
              KTestText.informationModelItems.last.status,
          InformationModelJsonField.directLink:
              KTestText.informationModelItems.last.directLink,
          InformationModelJsonField.link:
              KTestText.informationModelItems.last.link,
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
          informationModel.fetchDate,
          KTestText.informationModelItems.last.fetchDate,
        );
        expect(
          informationModel.image,
          KTestText.informationModelItems.last.image,
        );
        expect(
          informationModel.category,
          KTestText.informationModelItems.last.category,
        );
        expect(
          informationModel.categoryUA,
          KTestText.informationModelItems.last.categoryUA,
        );
        expect(
          informationModel.topic,
          KTestText.informationModelItems.last.topic,
        );
        expect(
          informationModel.topicUA,
          KTestText.informationModelItems.last.topicUA,
        );
        expect(
          informationModel.status,
          KTestText.informationModelItems.last.status,
        );
        expect(
          informationModel.directLink,
          KTestText.informationModelItems.last.directLink,
        );
        expect(
          informationModel.link,
          KTestText.informationModelItems.last.link,
        );
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          InformationModelJsonField.id: KTestText.informationModelItems.last.id,
          InformationModelJsonField.title:
              KTestText.informationModelItems.last.title,
          InformationModelJsonField.news:
              KTestText.informationModelItems.last.news,
          InformationModelJsonField.fetchDate:
              KTestText.informationModelItems.last.fetchDate.toIso8601String(),
          InformationModelJsonField.category:
              KTestText.informationModelItems.last.category,
          InformationModelJsonField.categoryUA:
              KTestText.informationModelItems.last.categoryUA,
          InformationModelJsonField.topic:
              KTestText.informationModelItems.last.topic,
          InformationModelJsonField.topicUA:
              KTestText.informationModelItems.last.topicUA,
          InformationModelJsonField.status:
              KTestText.informationModelItems.last.status,
          InformationModelJsonField.directLink:
              KTestText.informationModelItems.last.directLink,
          InformationModelJsonField.link:
              KTestText.informationModelItems.last.link,
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
          informationModel.fetchDate,
          KTestText.informationModelItems.last.fetchDate,
        );
        expect(
          informationModel.image,
          null,
        );
        expect(
          informationModel.category,
          KTestText.informationModelItems.last.category,
        );
        expect(
          informationModel.categoryUA,
          KTestText.informationModelItems.last.categoryUA,
        );
        expect(
          informationModel.topic,
          KTestText.informationModelItems.last.topic,
        );
        expect(
          informationModel.topicUA,
          KTestText.informationModelItems.last.topicUA,
        );
        expect(
          informationModel.status,
          KTestText.informationModelItems.last.status,
        );
        expect(
          informationModel.directLink,
          KTestText.informationModelItems.last.directLink,
        );
        expect(
          informationModel.link,
          KTestText.informationModelItems.last.link,
        );
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          InformationModelJsonField.id: KTestText.informationModelItems.last.id,
          // title is missing
          InformationModelJsonField.news:
              KTestText.informationModelItems.last.news,
          InformationModelJsonField.fetchDate:
              KTestText.informationModelItems.last.fetchDate.toIso8601String(),
          InformationModelJsonField.category:
              KTestText.informationModelItems.last.category,
          InformationModelJsonField.categoryUA:
              KTestText.informationModelItems.last.categoryUA,
          InformationModelJsonField.image: [
            KTestText.informationModelItems.last.image!.first.toJson(),
          ],
          InformationModelJsonField.topic:
              KTestText.informationModelItems.last.topic,
          InformationModelJsonField.topicUA:
              KTestText.informationModelItems.last.topicUA,
          InformationModelJsonField.status:
              KTestText.informationModelItems.last.status,
          InformationModelJsonField.directLink:
              KTestText.informationModelItems.last.directLink,
          InformationModelJsonField.link:
              KTestText.informationModelItems.last.link,
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
          InformationModelJsonField.id: KTestText.informationModelItems.last.id,
          InformationModelJsonField.title:
              KTestText.informationModelItems.last.title,
          InformationModelJsonField.news:
              KTestText.informationModelItems.last.news,
          InformationModelJsonField.fetchDate:
              KTestText.informationModelItems.last.fetchDate.toIso8601String(),
          InformationModelJsonField.category:
              KTestText.informationModelItems.last.category,
          InformationModelJsonField.image: [
            KTestText.informationModelItems.last.image!.first.toJson(),
          ],
          InformationModelJsonField.categoryUA:
              KTestText.informationModelItems.last.categoryUA,
          InformationModelJsonField.topic:
              KTestText.informationModelItems.last.topic,
          InformationModelJsonField.topicUA:
              KTestText.informationModelItems.last.topicUA,
          InformationModelJsonField.status:
              KTestText.informationModelItems.last.status,
          InformationModelJsonField.directLink:
              KTestText.informationModelItems.last.directLink,
          InformationModelJsonField.link:
              KTestText.informationModelItems.last.link,
        };

        final informationModelJson =
            KTestText.informationModelItems.last.toJson();

        expect(informationModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          InformationModelJsonField.id: KTestText.informationModelItems.last.id,
          InformationModelJsonField.title:
              KTestText.informationModelItems.last.title,
          InformationModelJsonField.news:
              KTestText.informationModelItems.last.news,
          InformationModelJsonField.fetchDate:
              KTestText.informationModelItems.last.fetchDate.toIso8601String(),
          InformationModelJsonField.category:
              KTestText.informationModelItems.last.category,
          InformationModelJsonField.image: null,
          InformationModelJsonField.categoryUA:
              KTestText.informationModelItems.last.categoryUA,
          InformationModelJsonField.topic:
              KTestText.informationModelItems.last.topic,
          InformationModelJsonField.topicUA:
              KTestText.informationModelItems.last.topicUA,
          InformationModelJsonField.status:
              KTestText.informationModelItems.last.status,
          InformationModelJsonField.directLink:
              KTestText.informationModelItems.last.directLink,
          InformationModelJsonField.link:
              KTestText.informationModelItems.last.link,
        };

        final informationModelJson =
            KTestText.informationModelItems.last.copyWith(image: null).toJson();

        expect(informationModelJson, json);
      });
    });
  });
}
