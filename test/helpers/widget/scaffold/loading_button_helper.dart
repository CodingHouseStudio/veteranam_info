import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> loadingButtonHelper(
  WidgetTester tester,
) async {
  final isDesk = find.byKey(LoadingButtonKeys.desk).evaluate().isNotEmpty;

  expect(
    find.byKey(LoadingButtonKeys.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(LoadingButtonKeys.mob),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(LoadingButtonKeys.icon), findsWidgets);

  expect(find.byKey(LoadingButtonKeys.text), findsWidgets);

  expect(
    find.byKey(LoadingButtonKeys.loadingIcon),
    findsNothing,
  );

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: LoadingButtonKeys.text,
      hoverElement: LoadingButtonKeys.loadingIcon,
      usePump: true,
    );
  }
}
