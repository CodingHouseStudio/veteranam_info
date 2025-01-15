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
//         find.byKey(ProfileKeys.boxSaves),
//         findsOneWidget,
//       );

//       await scrollingHelper(
//         tester: tester,
//         itemKey: ProfileKeys.boxSaves,
//       );

//       await tester.tap(find.byKey(ProfileKeys.boxSaves));

//       verify(() => mockGoRouter.goNamed(KRoute.profileSaves.name)).called(1);

//       expect(
//         find.byKey(ProfileKeys.boxStory),
//         findsOneWidget,
//       );

//       await scrollingHelper(
//         tester: tester,
//         itemKey: ProfileKeys.boxStory,
//       );

//       await tester.tap(find.byKey(ProfileKeys.boxStory));

//       verify(() => mockGoRouter.goNamed(KRoute.profileMyStory.name))
// .called(1);

//       expect(
//         find.byKey(ProfileKeys.boxFeedback),
//         findsOneWidget,
//       );

//       await scrollingHelper(
//         tester: tester,
//         itemKey: ProfileKeys.boxFeedback,
//       );

//       await tester.tap(find.byKey(ProfileKeys.boxFeedback));

//       verify(() => mockGoRouter.goNamed(KRoute.feedback.name)).called(1);
//     },
//   );
// }
