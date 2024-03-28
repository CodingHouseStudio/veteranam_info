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

    await tester.tap(find.byKey(KWidgetkeys.homeKeys.storyButton));
    await tester.pumpAndSettle();

    expect(find.byKey(KWidgetkeys.storyKeys.screen), findsOneWidget);

    expect(find.byKey(KWidgetkeys.storyKeys.discountsButton), findsOneWidget);

    expect(
      find.byKey(KWidgetkeys.storyKeys.informationButton),
      findsOneWidget,
    );

    expect(find.byKey(KWidgetkeys.storyKeys.investorsButton), findsOneWidget);

    expect(find.byKey(KWidgetkeys.storyKeys.profileButton), findsOneWidget);

    expect(find.byKey(KWidgetkeys.storyKeys.workButton), findsOneWidget);
  });
}
