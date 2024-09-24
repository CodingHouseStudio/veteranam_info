// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:veteranam/shared/shared.dart';

// import '../../test_dependency.dart';

// Future<void> profileNavigationHelper({
//   required WidgetTester tester,
//   required MockGoRouter mockGoRouter,
// }) async {
//   await changeWindowSizeHelper(
//     tester: tester,
//     windowsTest: true,
//     test: () async {
//       expect(
//         find.byKey(KWidgetkeys.screen.profile.boxSaves),
//         findsOneWidget,
//       );

//       await scrollingHelper(
//         tester: tester,
//         itemKey: KWidgetkeys.screen.profile.boxSaves,
//       );

//       await tester.tap(find.byKey(KWidgetkeys.screen.profile.boxSaves));

//       verify(() => mockGoRouter.goNamed(KRoute.profileSaves.name)).called(1);

//       expect(
//         find.byKey(KWidgetkeys.screen.profile.boxStory),
//         findsOneWidget,
//       );

//       await scrollingHelper(
//         tester: tester,
//         itemKey: KWidgetkeys.screen.profile.boxStory,
//       );

//       await tester.tap(find.byKey(KWidgetkeys.screen.profile.boxStory));

//       verify(() => mockGoRouter.goNamed(KRoute.profileMyStory.name)).called(1);

//       expect(
//         find.byKey(KWidgetkeys.screen.profile.boxFeedback),
//         findsOneWidget,
//       );

//       await scrollingHelper(
//         tester: tester,
//         itemKey: KWidgetkeys.screen.profile.boxFeedback,
//       );

//       await tester.tap(find.byKey(KWidgetkeys.screen.profile.boxFeedback));

//       verify(() => mockGoRouter.goNamed(KRoute.feedback.name)).called(1);
//     },
//   );
// }
