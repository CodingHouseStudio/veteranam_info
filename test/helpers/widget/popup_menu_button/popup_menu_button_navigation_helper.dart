// import 'package:flutter_test/flutter_test.dart';
// import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

// import '../../../test_dependency.dart';

// Future<void> popupMenyButtonNavigationHelper({
//   required WidgetTester tester,
//   required MockGoRouter mockGoRouter,
// }) async {
//   await scrollingHelper(
//     tester: tester,
//     offset: KTestConstants.scrollingDown,
//     itemKey: DropDownButtonKeys.loginButton,
//   );

//   expect(
//     find.byKey(DropDownButtonKeys.loginButton),
//     findsOneWidget,
//   );

//   await tester.tap(
//     find.byKey(DropDownButtonKeys.loginButton),
//     warnIfMissed: false,
//   );

//   await tester.pumpAndSettle();

//   // expect(
//   //   find.byKey(UserRoleKeys.loginBusinessButton),
//   //   findsOneWidget,
//   // );

//   // // await tester
//   // //     .tap(find.byKey(UserRoleKeys.loginBusinessButton));

//   // // await tester.pumpAndSettle();

//   // expect(
//   //   find.byKey(UserRoleKeys.loginUserButton),
//   //   findsOneWidget,
//   // );

//   // // await scrollingHelper(
//   // //   tester: tester,
//   // //   itemKey: UserRoleKeys.loginUserButton,
//   // // );

//   // await tester.tap(find.byKey(UserRoleKeys.loginUserButton));

//   // await tester.pumpAndSettle();

//   // verify(
//   //   () => mockGoRouter.goNamed(KRoute.login.name),
//   // ).called(1);
// }
