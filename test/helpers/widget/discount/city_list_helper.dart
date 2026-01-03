import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> cityListHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: CityListKeys.icon,
  );

  expect(
    find.byKey(CityListKeys.icon),
    findsWidgets,
  );

  if (find.byKey(CityListKeys.text).evaluate().isNotEmpty) {
    expect(
      find.byKey(CityListKeys.text),
      findsWidgets,
    );
  }

  if (find.byKey(CityListKeys.longText).evaluate().isNotEmpty) {
    expect(
      find.byKey(CityListKeys.longText),
      findsWidgets,
    );

    await tester.tapOnTextCustom(
      text: 'Ще',
      englishText: 'more',
    );

    await tester.pumpAndSettle();

    // await tester.tapOnTextCustom(text: 'сховати', englishText: 'hide');

    // await tester.pumpAndSettle();
  }
}
