import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.information} ${KGroupText.model} ', () {
    final fullJson = {
      InformationModelJsonField.id:
          KTestVariables.informationModelItems.last.id,
      InformationModelJsonField.title:
          KTestVariables.informationModelItems.last.title,
      InformationModelJsonField.news:
          KTestVariables.informationModelItems.last.news,
      InformationModelJsonField.fetchDate:
          KTestVariables.informationModelItems.last.fetchDate.toIso8601String(),
      InformationModelJsonField.category:
          KTestVariables.informationModelItems.last.category,
      InformationModelJsonField.image: [
        KTestVariables.informationModelItems.last.image!.toJson(),
      ],
      InformationModelJsonField.categoryUA:
          KTestVariables.informationModelItems.last.categoryUA,
      InformationModelJsonField.topic:
          KTestVariables.informationModelItems.last.topic,
      InformationModelJsonField.topicUA:
          KTestVariables.informationModelItems.last.topicUA,
      InformationModelJsonField.status:
          KTestVariables.informationModelItems.last.status,
      InformationModelJsonField.likes:
          KTestVariables.informationModelItems.last.likes,
    };
    final nullableJson = {
      InformationModelJsonField.id:
          KTestVariables.informationModelItems.last.id,
      InformationModelJsonField.title:
          KTestVariables.informationModelItems.last.title,
      InformationModelJsonField.news:
          KTestVariables.informationModelItems.last.news,
      InformationModelJsonField.fetchDate:
          KTestVariables.informationModelItems.last.fetchDate.toIso8601String(),
      InformationModelJsonField.category:
          KTestVariables.informationModelItems.last.category,
      InformationModelJsonField.image: null,
      InformationModelJsonField.categoryUA:
          KTestVariables.informationModelItems.last.categoryUA,
      InformationModelJsonField.topic:
          KTestVariables.informationModelItems.last.topic,
      InformationModelJsonField.topicUA:
          KTestVariables.informationModelItems.last.topicUA,
      InformationModelJsonField.status:
          KTestVariables.informationModelItems.last.status,
      InformationModelJsonField.likes: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final informationModel = InformationModel.fromJson(fullJson);

        expect(
          informationModel.id,
          KTestVariables.informationModelItems.last.id,
        );
        expect(
          informationModel.title,
          KTestVariables.informationModelItems.last.title,
        );
        expect(
          informationModel.news,
          KTestVariables.informationModelItems.last.news,
        );
        expect(
          informationModel.fetchDate,
          KTestVariables.informationModelItems.last.fetchDate,
        );
        expect(
          informationModel.image,
          KTestVariables.informationModelItems.last.image,
        );
        expect(
          informationModel.category,
          KTestVariables.informationModelItems.last.category,
        );
        expect(
          informationModel.categoryUA,
          KTestVariables.informationModelItems.last.categoryUA,
        );
        expect(
          informationModel.topic,
          KTestVariables.informationModelItems.last.topic,
        );
        expect(
          informationModel.topicUA,
          KTestVariables.informationModelItems.last.topicUA,
        );
        expect(
          informationModel.status,
          KTestVariables.informationModelItems.last.status,
        );
        expect(
          informationModel.likes,
          KTestVariables.informationModelItems.last.likes,
        );
      });

      test('${KGroupText.nullable} ', () {
        final informationModel = InformationModel.fromJson(nullableJson);

        expect(
          informationModel.id,
          KTestVariables.informationModelItems.last.id,
        );
        expect(
          informationModel.title,
          KTestVariables.informationModelItems.last.title,
        );
        expect(
          informationModel.news,
          KTestVariables.informationModelItems.last.news,
        );
        expect(
          informationModel.fetchDate,
          KTestVariables.informationModelItems.last.fetchDate,
        );
        expect(
          informationModel.image,
          null,
        );
        expect(
          informationModel.category,
          KTestVariables.informationModelItems.last.category,
        );
        expect(
          informationModel.categoryUA,
          KTestVariables.informationModelItems.last.categoryUA,
        );
        expect(
          informationModel.topic,
          KTestVariables.informationModelItems.last.topic,
        );
        expect(
          informationModel.topicUA,
          KTestVariables.informationModelItems.last.topicUA,
        );
        expect(
          informationModel.status,
          KTestVariables.informationModelItems.last.status,
        );
        expect(
          informationModel.likes,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          InformationModelJsonField.id:
              KTestVariables.informationModelItems.last.id,
          // title is missing
          InformationModelJsonField.news:
              KTestVariables.informationModelItems.last.news,
          InformationModelJsonField.fetchDate: KTestVariables
              .informationModelItems.last.fetchDate
              .toIso8601String(),
          InformationModelJsonField.category:
              KTestVariables.informationModelItems.last.category,
          InformationModelJsonField.categoryUA:
              KTestVariables.informationModelItems.last.categoryUA,
          InformationModelJsonField.image: [
            KTestVariables.informationModelItems.last.image!.toJson(),
          ],
          InformationModelJsonField.topic:
              KTestVariables.informationModelItems.last.topic,
          InformationModelJsonField.topicUA:
              KTestVariables.informationModelItems.last.topicUA,
          InformationModelJsonField.status:
              KTestVariables.informationModelItems.last.status,
          InformationModelJsonField.likes:
              KTestVariables.informationModelItems.last.likes,
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
            KTestVariables.informationModelItems.last.toJson();

        expect(informationModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final informationModelJson = KTestVariables.informationModelItems.last
            .copyWith(image: null, likes: null)
            .toJson();

        expect(informationModelJson, nullableJson);
      });
    });
  });
}
