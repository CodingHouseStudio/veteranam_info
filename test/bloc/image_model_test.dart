import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  group('${KScreenBlocName.image} ${KGroupText.model} ', () {
    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'downloadURL': KTestText.imageModel.downloadURL,
        'lastModifiedTS': KTestText.imageModel.lastModifiedTS,
        'name': KTestText.imageModel.name,
        'ref': KTestText.imageModel.ref,
        'type': KTestText.imageModel.type,
      };

      final imageModel = ImageModel.fromJson(json);

      expect(imageModel.downloadURL, KTestText.imageModel.downloadURL);
      expect(imageModel.lastModifiedTS, KTestText.imageModel.lastModifiedTS);
      expect(imageModel.name, KTestText.imageModel.name);
      expect(imageModel.ref, KTestText.imageModel.ref);
      expect(imageModel.type, KTestText.imageModel.type);
    });

    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'downloadURL': KTestText.imageModel.downloadURL,
      };

      final imageModel = ImageModel.fromJson(json);

      expect(imageModel.downloadURL, KTestText.imageModel.downloadURL);
      expect(imageModel.lastModifiedTS, null);
      expect(imageModel.name, null);
      expect(imageModel.ref, null);
      expect(imageModel.type, null);
    });

    test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
      final json = {
        // downloadURL is missing
        'lastModifiedTS': KTestText.imageModel.lastModifiedTS,
        'name': KTestText.imageModel.name,
        'ref': KTestText.imageModel.ref,
        'type': KTestText.imageModel.type,
      };

      expect(
        () => ImageModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
