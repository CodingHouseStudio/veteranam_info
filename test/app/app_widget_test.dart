import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.app} ', () {
    setUpAll(appWidgetTestRegister);

    group('Mobile', () {
      setUp(() => Config.testIsWeb = false);
      testWidgets('${KGroupText.initial} ', (tester) async {
        await appPumpAppHelper(
          tester,
        );
      });
    });

    group('Web', () {
      setUp(() => Config.testIsWeb = true);
      testWidgets('${KGroupText.initial} ', (tester) async {
        await appPumpAppHelper(
          tester,
        );
      });
    });
  });
}
