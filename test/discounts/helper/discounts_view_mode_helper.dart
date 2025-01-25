import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountsViewModeHelper(
  WidgetTester tester,
) async {
  if (find.byKey(DiscountsKeys.viewMode).evaluate().isNotEmpty) {
    expect(find.byKey(DiscountsKeys.viewMode), findsOneWidget);

    await scrollingHelper(tester: tester, itemKey: DiscountsKeys.viewMode);

    expect(find.byKey(DiscountsKeys.horizontalViewModeIcon), findsOneWidget);

    expect(find.byKey(DiscountsKeys.verticalViewModeIcon), findsOneWidget);

    expect(find.byKey(DiscountsKeys.verticalList), findsOneWidget);

    expect(find.byKey(DiscountsKeys.horizontalList), findsNothing);

    await tester.tap(find.byKey(DiscountsKeys.horizontalViewModeIcon));

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsKeys.verticalList), findsNothing);

    expect(find.byKey(DiscountsKeys.horizontalList), findsOneWidget);

    await tester.tap(find.byKey(DiscountsKeys.verticalViewModeIcon));

    await tester.pumpAndSettle();

    expect(find.byKey(DiscountsKeys.verticalList), findsOneWidget);

    expect(find.byKey(DiscountsKeys.horizontalList), findsNothing);
  }
}
