import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> informationInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(InformationKeys.screen), findsOneWidget);

  // await nawbarHelper(
  //   tester: tester,
  //   searchText: KTestText.field,
  // );
  expect(
    find.byKey(InformationKeys.title),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(InformationKeys.subtitle),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(InformationKeys.filter),
    findsOneWidget,
  );

  await filterChipHelper(tester);

  expect(
    find.byKey(InformationKeys.card),
    findsWidgets,
  );

  await newsCardHelper(tester: tester);

  expect(
    find.byKey(InformationKeys.buttonMock),
    findsNothing,
  );

  // await scrollingHelper(
  //   tester: tester,
  //   offset: KTestConstants.scrollingDown,
  // );

  // await scrollingHelper(
  //   tester: tester,
  //   offset: KTestConstants.scrollingUp500,
  // );

  // expect(
  //   find.byKey(InformationKeys.button),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(InformationKeys.buttonIcon),
  //   findsNothing,
  // );

  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async => expect(
  //     find.byKey(InformationKeys.buttonIcon),
  //     findsOneWidget,
  //   ),
  // );
}
