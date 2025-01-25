import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Filter ${KGroupText.model} ', () {
    test('${KGroupText.initial} ', () {
      const filterModel = FilterItem(
        KTestVariables.translateModel,
        isSelected: true,
        number: 10,
      );

      expect(filterModel.isSelected, isTrue);

      expect(filterModel.number, 10);

      expect(filterModel.value, KTestVariables.translateModel);

      const translateModel = TranslateModel(uk: KTestVariables.field);

      final copyFilterModel = filterModel.copyWith(
        number: 0,
        isSelected: false,
        value: translateModel,
      );

      expect(copyFilterModel.isSelected, isFalse);

      expect(copyFilterModel.number, 0);

      expect(copyFilterModel.value, translateModel);

      final copyFilterModelWithoutChanged = filterModel.copyWith();

      expect(copyFilterModelWithoutChanged.isSelected, isTrue);

      expect(copyFilterModelWithoutChanged.number, 10);

      expect(
        copyFilterModelWithoutChanged.value,
        KTestVariables.translateModel,
      );
    });
  });
}
