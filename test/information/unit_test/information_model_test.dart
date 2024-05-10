import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.information} ${KGroupText.model} ', () {
    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.informationModelItems.elementAt(0).id,
        'title': KTestText.informationModelItems.elementAt(0).title,
        'news': KTestText.informationModelItems.elementAt(0).news,
        'date':
            KTestText.informationModelItems.elementAt(0).date.toIso8601String(),
        'tags': KTestText.informationModelItems.elementAt(0).tags,
        'image': KTestText.informationModelItems.elementAt(0).image,
      };

      final informationModel = InformationModel.fromJson(json);

      expect(
        informationModel.id,
        KTestText.informationModelItems.elementAt(0).id,
      );
      expect(
        informationModel.title,
        KTestText.informationModelItems.elementAt(0).title,
      );
      expect(
        informationModel.news,
        KTestText.informationModelItems.elementAt(0).news,
      );
      expect(
        informationModel.date,
        KTestText.informationModelItems.elementAt(0).date,
      );
      expect(
        informationModel.image,
        KTestText.informationModelItems.elementAt(0).image,
      );
      expect(
        informationModel.tags,
        KTestText.informationModelItems.elementAt(0).tags,
      );
    });

    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.informationModelItems.elementAt(0).id,
        'title': KTestText.informationModelItems.elementAt(0).title,
        'news': KTestText.informationModelItems.elementAt(0).news,
        'date':
            KTestText.informationModelItems.elementAt(0).date.toIso8601String(),
      };

      final informationModel = InformationModel.fromJson(json);

      expect(
        informationModel.id,
        KTestText.informationModelItems.elementAt(0).id,
      );
      expect(
        informationModel.title,
        KTestText.informationModelItems.elementAt(0).title,
      );
      expect(
        informationModel.news,
        KTestText.informationModelItems.elementAt(0).news,
      );
      expect(
        informationModel.date,
        KTestText.informationModelItems.elementAt(0).date,
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

    test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.informationModelItems.elementAt(0).id,
        // title is missing
        'news': KTestText.informationModelItems.elementAt(0).news,
        'date':
            KTestText.informationModelItems.elementAt(0).date.toIso8601String(),
      };

      expect(
        () => InformationModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
