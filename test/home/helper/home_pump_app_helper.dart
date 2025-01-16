import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/home/view/home_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> homePumpAppHelper({
  // required IFeedbackRepository mockFeedbackRepository,
  required IFaqRepository mockFaqRepository,
  required UserRepository mockUserRepository,
  required AuthenticationRepository mockAuthencticationRepository,
  required WidgetTester tester,
  required IUrlRepository mockUrlRepository,
  required AppInfoRepository mockBuildRepository,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
  MockGoRouter? mockGoRouter,
}) async {
  // _registerFeedbackBloc(
  //   mockFeedbackRepository: mockFeedbackRepository,
  //   mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  // );
  _registerAuthenticationBloc(
    mockAuthencticationRepository: mockAuthencticationRepository,
  );
  _registerHomeBloc(mockFaqRepository: mockFaqRepository);
  _registerUserWatcherBloc(
    mockUserRepository: mockUserRepository,
  );
  _registerUrlCubit(mockUrlRepository);
  _registerBuildCubit(
    mockBuildRepository: mockBuildRepository,
    mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
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

void _registerHomeBloc({
  required IFaqRepository mockFaqRepository,
}) {
  final homeBloc = HomeWatcherBloc(faqRepository: mockFaqRepository);
  if (GetIt.I.isRegistered<HomeWatcherBloc>()) {
    GetIt.I.unregister<HomeWatcherBloc>();
  }
  GetIt.I.registerSingleton<HomeWatcherBloc>(homeBloc);
}

void _registerUserWatcherBloc({
  required UserRepository mockUserRepository,
}) {
  final userWatcherBloc = UserWatcherBloc(
    userRepository: mockUserRepository,
  );
  if (GetIt.I.isRegistered<UserWatcherBloc>()) {
    GetIt.I.unregister<UserWatcherBloc>();
  }
  GetIt.I.registerSingleton<UserWatcherBloc>(userWatcherBloc);
}

void _registerAuthenticationBloc({
  required AuthenticationRepository mockAuthencticationRepository,
}) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthencticationRepository,
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

void _registerBuildCubit({
  required AppInfoRepository mockBuildRepository,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
}) {
  final urlCubit = AppVersionCubit(
    buildRepository: mockBuildRepository,
    firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (GetIt.I.isRegistered<AppVersionCubit>()) {
    GetIt.I.unregister<AppVersionCubit>();
  }
  GetIt.I.registerSingleton<AppVersionCubit>(urlCubit);
}
