import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kozak/shared/shared.dart';

import 'helper/helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  // setUpAll(setUpGlobalIntegration);

  // tearDownAll(getIt.reset);

  testWidgets('Home Page opened', (tester) async {
    await homeHelper(tester);

    await tester.tap(find.byKey(KWidgetkeys.homeKeys.profileButton));
    await tester.pumpAndSettle();

    expect(find.byKey(KWidgetkeys.profileKeys.screen), findsOneWidget);

    expect(
      find.byKey(KWidgetkeys.profileKeys.discountsButton),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.profileKeys.informationButton),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.profileKeys.investorsButton),
      findsOneWidget,
    );

    expect(find.byKey(KWidgetkeys.profileKeys.storyButton), findsOneWidget);

    expect(find.byKey(KWidgetkeys.profileKeys.workButton), findsOneWidget);
  });
}
