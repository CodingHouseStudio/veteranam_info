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

    await tester.tap(find.byKey(KWidgetkeys.homeKeys.workButton));
    await tester.pumpAndSettle();

    expect(find.byKey(KWidgetkeys.workKeys.screen), findsOneWidget);

    expect(find.byKey(KWidgetkeys.workKeys.discountsButton), findsOneWidget);

    expect(
      find.byKey(KWidgetkeys.workKeys.informationButton),
      findsOneWidget,
    );

    expect(find.byKey(KWidgetkeys.workKeys.investorsButton), findsOneWidget);

    expect(find.byKey(KWidgetkeys.workKeys.profileButton), findsOneWidget);

    expect(find.byKey(KWidgetkeys.workKeys.storyButton), findsOneWidget);
  });
}
