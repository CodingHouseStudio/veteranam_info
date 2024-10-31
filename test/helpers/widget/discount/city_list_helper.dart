import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> cityListHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.cityList.icon,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cityList.icon),
    findsWidgets,
  );

  if (find.byKey(KWidgetkeys.widget.cityList.text).evaluate().isNotEmpty) {
    expect(
      find.byKey(KWidgetkeys.widget.cityList.text),
      findsWidgets,
    );
  }

  if (find.byKey(KWidgetkeys.widget.cityList.markdown).evaluate().isNotEmpty) {
    expect(
      find.byKey(KWidgetkeys.widget.cityList.markdown),
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
