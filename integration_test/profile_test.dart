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

    await tester.tap(find.byKey(KWIdgetkeys.homeKeys.profileButton));
    await tester.pumpAndSettle();

    expect(find.byKey(KWIdgetkeys.profileKeys.screen), findsOneWidget);

    expect(
      find.byKey(KWIdgetkeys.profileKeys.discountsButton),
      findsOneWidget,
    );

    expect(
      find.byKey(KWIdgetkeys.profileKeys.informationButton),
      findsOneWidget,
    );

    expect(
      find.byKey(KWIdgetkeys.profileKeys.investorsButton),
      findsOneWidget,
    );

    expect(find.byKey(KWIdgetkeys.profileKeys.storyButton), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.profileKeys.workButton), findsOneWidget);
  });
}
