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

    await tester.tap(find.byKey(KWIdgetkeys.homeKeys.storyButton));
    await tester.pumpAndSettle();

    expect(find.byKey(KWIdgetkeys.storyKeys.screen), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.storyKeys.discountsButton), findsOneWidget);

    expect(
      find.byKey(KWIdgetkeys.storyKeys.informationButton),
      findsOneWidget,
    );

    expect(find.byKey(KWIdgetkeys.storyKeys.investorsButton), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.storyKeys.profileButton), findsOneWidget);

    expect(find.byKey(KWIdgetkeys.storyKeys.workButton), findsOneWidget);
  });
}
