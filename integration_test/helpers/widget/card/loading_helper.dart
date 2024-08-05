import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

void loadingList(
  Future<void> Function(WidgetTester) pumpApp,
  // required Key lastCard,
) {
  group('Loading List', () {
    testWidgets('Desk', (tester) async {
      KPlatformConstants.isWebDesktop = true;
      await pumpApp(tester);

      await _deskLoadingHelper(
        tester,
        // cardLast: lastCard,
      );
    });
    testWidgets('Mobile', (tester) async {
      KPlatformConstants.isWebDesktop = false;
      await pumpApp(tester);

      await _mobileLoadingHelper(
        tester,
        // cardLast: lastCard,
      );
    });
  });
}

// void loadingListSeparate({
//   required Future<void> Function(WidgetTester) pumpApp,
//   required Key lastCard,
// }) {
//   group('Loading List', () {
//     testWidgets('Desk(isNotDesk)', (tester) async {
//       KPlatformConstants.isWebDesktop = true;
//       await pumpApp(tester);

//       await _deskLoadingHelper(
//         tester: tester,
//         cardLast: lastCard,
//       );
//     });
//     testWidgets('Desk(isDesk)', (tester) async {
//       KPlatformConstants.isWebDesktop = true;
//       await pumpApp(tester);

//       await changeWindowSizeHelper(
//         tester: tester,
//         test: () async {
//           await _deskLoadingHelper(
//             tester: tester,
//             cardLast: lastCard,
//           );
//         },
//       );
//     });
//     testWidgets('Mobile', (tester) async {
//       KPlatformConstants.isWebDesktop = false;
//       await pumpApp(tester);

//       await _mobileLoadingHelper(
//         tester: tester,
//         cardLast: lastCard,
//       );
//     });
//   });
// }

Future<void> _deskLoadingHelper(
  WidgetTester tester,
  // required Key cardLast,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  // expect(
  //   find.byKey(cardLast),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.scaffold.loadingButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.scaffold.endListText),
    findsNothing,
  );
}

Future<void> _mobileLoadingHelper(
  WidgetTester tester,
  // required Key cardLast,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.widget.scaffold.loadingButton),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.scaffold.endListText),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.widget.scaffold.endListText),
    findsNothing,
  );
}
