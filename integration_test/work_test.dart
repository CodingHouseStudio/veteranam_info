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

    await tester.tap(find.byKey(KWIdgetkeys.homeKeys.workButton));
    await tester.pumpAndSettle();

    expect(find.byKey(KWIdgetkeys.workKeys.screen), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.workKeys.discountsButton), findsOneWidget);

    expect(
      find.byKey(KWIdgetkeys.workKeys.informationButton),
      findsOneWidget,
    );

    expect(find.byKey(KWIdgetkeys.workKeys.investorsButton), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.workKeys.profileButton), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.workKeys.storyButton), findsOneWidget);
  });
}
