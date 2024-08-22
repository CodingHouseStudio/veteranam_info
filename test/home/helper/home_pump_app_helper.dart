import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> homePumpAppHelper({
  // required IFeedbackRepository mockFeedbackRepository,
  required IFaqRepository mockFaqRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  // required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  required IUrlRepository mockUrlRepository,
  MockGoRouter? mockGoRouter,
}) async {
  // _registerFeedbackBloc(
  //   mockFeedbackRepository: mockFeedbackRepository,
  //   mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  // );
  _registerHomeBloc(mockFaqRepository: mockFaqRepository);
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  _registerUrlCubit(mockUrlRepository);
  await tester.pumpApp(
    const HomeScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

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

void _registerHomeBloc({
  required IFaqRepository mockFaqRepository,
}) {
  final homeBloc = HomeWatcherBloc(faqRepository: mockFaqRepository);
  if (GetIt.I.isRegistered<HomeWatcherBloc>()) {
    GetIt.I.unregister<HomeWatcherBloc>();
  }
  GetIt.I.registerSingleton<HomeWatcherBloc>(homeBloc);
}

void _registerAuthenticationBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}

void _registerUrlCubit(
  IUrlRepository mockUrlRepository,
) {
  final urlCubit = UrlCubit(
    urlRepository: mockUrlRepository,
  );
  if (GetIt.I.isRegistered<UrlCubit>()) {
    GetIt.I.unregister<UrlCubit>();
  }
  GetIt.I.registerSingleton<UrlCubit>(urlCubit);
}
