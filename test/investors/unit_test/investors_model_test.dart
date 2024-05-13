import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.investors} ${KGroupText.model} ', () {
    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.fundItems.elementAt(0).id,
        'title': KTestText.fundItems.elementAt(0).title,
        'subtitle': KTestText.fundItems.elementAt(0).subtitle,
        'link': KTestText.fundItems.elementAt(0).link,
        'image': KTestText.fundItems.elementAt(0).image,
      };

      final fundModel = FundModel.fromJson(json);

      expect(fundModel.id, KTestText.fundItems.elementAt(0).id);
      expect(
        fundModel.title,
        KTestText.fundItems.elementAt(0).title,
      );
      expect(
        fundModel.subtitle,
        KTestText.fundItems.elementAt(0).subtitle,
      );
      expect(
        fundModel.link,
        KTestText.fundItems.elementAt(0).link,
      );
      expect(
        fundModel.image,
        KTestText.fundItems.elementAt(0).image,
      );
    });

    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.fundItems.elementAt(0).id,
        'title': KTestText.fundItems.elementAt(0).title,
        'subtitle': KTestText.fundItems.elementAt(0).subtitle,
        'link': KTestText.fundItems.elementAt(0).link,
      };

      final fundModel = FundModel.fromJson(json);

      expect(fundModel.id, KTestText.fundItems.elementAt(0).id);
      expect(
        fundModel.title,
        KTestText.fundItems.elementAt(0).title,
      );
      expect(
        fundModel.subtitle,
        KTestText.fundItems.elementAt(0).subtitle,
      );
      expect(
        fundModel.link,
        KTestText.fundItems.elementAt(0).link,
      );
      expect(
        fundModel.image,
        null,
      );
    });

    test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.fundItems.elementAt(0).id,
        // title is missing
        'subtitle': KTestText.fundItems.elementAt(0).subtitle,
        'link': KTestText.fundItems.elementAt(0).link,
        'image': KTestText.fundItems.elementAt(0).image,
      };

      expect(
        () => FundModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
