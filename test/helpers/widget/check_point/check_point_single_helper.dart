// import 'package:flutter_test/flutter_test.dart';
// import 'package:veteranam/shared/shared.dart';

// import '../../../test_dependency.dart';

// Future<void> chekPointSingleHelper({
//   required WidgetTester tester,
//   bool hasAmount = false,
// }) async {
//   await scrollingHelper(
//     tester: tester,
//     itemKey: CheckPointSingleKeys.widget,
//   );
//   expect(
//     find.byKey(CheckPointSingleKeys.widget),
//     findsWidgets,
//   );

//   expect(
//     find.byKey(CheckPointSingleKeys.icon),
//     findsNothing,
//   );

//   expect(
//     find.byKey(CheckPointKeys.ammount),
//     hasAmount ? findsWidgets : findsNothing,
//   );

//   await scrollingHelper(
//     tester: tester,
//     itemKey: CheckPointSingleKeys.widget,
//   );

//   await tester
//       .tap(find.byKey(CheckPointSingleKeys.widget).first);

//   await tester.pumpAndSettle();

//   expect(
//     find.byKey(CheckPointSingleKeys.icon),
//     findsOneWidget,
//   );

//   await tester
//       .tap(find.byKey(CheckPointSingleKeys.widget).first);

//   await tester.pumpAndSettle();

//   expect(
//     find.byKey(CheckPointSingleKeys.icon),
//     findsNothing,
//   );
// }
