import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.information} ${KGroupText.model} ', () {
    final fullJson = {
      InformationModelJsonField.id: KTestText.informationModelItems.last.id,
      InformationModelJsonField.title:
          KTestText.informationModelItems.last.title,
      InformationModelJsonField.news: KTestText.informationModelItems.last.news,
      InformationModelJsonField.fetchDate:
          KTestText.informationModelItems.last.fetchDate.toIso8601String(),
      InformationModelJsonField.category:
          KTestText.informationModelItems.last.category,
      InformationModelJsonField.image: [
        KTestText.informationModelItems.last.image!.toJson(),
      ],
      InformationModelJsonField.categoryUA:
          KTestText.informationModelItems.last.categoryUA,
      InformationModelJsonField.topic:
          KTestText.informationModelItems.last.topic,
      InformationModelJsonField.topicUA:
          KTestText.informationModelItems.last.topicUA,
      InformationModelJsonField.status:
          KTestText.informationModelItems.last.status,
      InformationModelJsonField.likes:
          KTestText.informationModelItems.last.likes,
    };
    final nullableJson = {
      InformationModelJsonField.id: KTestText.informationModelItems.last.id,
      InformationModelJsonField.title:
          KTestText.informationModelItems.last.title,
      InformationModelJsonField.news: KTestText.informationModelItems.last.news,
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
      InformationModelJsonField.likes: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final informationModel = InformationModel.fromJson(fullJson);

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
          informationModel.likes,
          KTestText.informationModelItems.last.likes,
        );
      });

      test('${KGroupText.nullable} ', () {
        final informationModel = InformationModel.fromJson(nullableJson);

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
          informationModel.likes,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
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
            KTestText.informationModelItems.last.image!.toJson(),
          ],
          InformationModelJsonField.topic:
              KTestText.informationModelItems.last.topic,
          InformationModelJsonField.topicUA:
              KTestText.informationModelItems.last.topicUA,
          InformationModelJsonField.status:
              KTestText.informationModelItems.last.status,
          InformationModelJsonField.likes:
              KTestText.informationModelItems.last.likes,
        };

        expect(
          () => InformationModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final informationModelJson =
            KTestText.informationModelItems.last.toJson();

        expect(informationModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final informationModelJson = KTestText.informationModelItems.last
            .copyWith(image: null, likes: null)
            .toJson();

        expect(informationModelJson, nullableJson);
      });
    });
  });
}
