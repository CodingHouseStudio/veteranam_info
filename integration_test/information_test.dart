import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kozak/shared/shared.dart';

import 'constants.dart';
import 'helper/helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(getIt.reset);

  testWidgets('Home Page opened', (tester) async {
    await homeHelper(tester);

    await footerInformationRoutHelper(tester);

    expect(find.byKey(KWidgetkeys.informationKeys.screen), findsOneWidget);

    await footerHelper(tester);
  });
}
