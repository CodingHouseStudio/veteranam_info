import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/home/view/home_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> homePumpAppHelper(
  // required IFeedbackRepository mockFeedbackRepository,
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  // _registerFeedbackBloc(
  //   mockFeedbackRepository: mockFeedbackRepository,
  //   mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  // );
  await tester.pumpApp(
    const HomeScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(find.byKey(HomeKeys.screen), findsOneWidget);

  await tester.pumpAndSettle();
}

// void _registerFeedbackBloc({
//   required IFeedbackRepository mockFeedbackRepository,
//   required IAppAuthenticationRepository mockAppAuthenticationRepository,
// }) {
//   final feedbackBloc = FeedbackBloc(
//     feedbackRepository: mockFeedbackRepository,
//     appAuthenticationRepository: mockAppAuthenticationRepository,
//   );
//   if (GetIt.I.isRegistered<FeedbackBloc>()) {
//     GetIt.I.unregister<FeedbackBloc>();
//   }
//   GetIt.I.registerSingleton<FeedbackBloc>(feedbackBloc);
// }
