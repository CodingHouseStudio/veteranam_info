import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kozak/shared/shared.dart';

import 'helper_home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  // setUpAll(setUpGlobalIntegration);

  // tearDownAll(getIt.reset);

  testWidgets('Home Page opened', (tester) async {
    await homeHelper(tester);

    await tester.tap(find.byKey(KWIdgetkeys.homeKeys.discountsButton));
    await tester.pumpAndSettle();

    expect(find.byKey(KWIdgetkeys.discountsKeys.screen), findsOneWidget);

    expect(
      find.byKey(KWIdgetkeys.discountsKeys.informationButton),
      findsOneWidget,
    );

    expect(
      find.byKey(KWIdgetkeys.discountsKeys.investorsButton),
      findsOneWidget,
    );

    expect(
      find.byKey(KWIdgetkeys.discountsKeys.profileButton),
      findsOneWidget,
    );

    expect(find.byKey(KWIdgetkeys.discountsKeys.storyButton), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.discountsKeys.workButton), findsOneWidget);
  });
}
