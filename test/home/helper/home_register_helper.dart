import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late UserRepository mockUserRepository;
late AuthenticationRepository mockAuthencticationRepository;
late IFaqRepository mockFaqRepository;
late IUrlRepository mockUrlRepository;
late AppInfoRepository mockBuildRepository;
late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
// late IFeedbackRepository mockFeedbackRepository;
// late IAppAuthenticationRepository mockAppAuthenticationRepository;
void homeWidgetTestRegister() {
  ExtendedDateTime.current = KTestVariables.dateTime;
  ExtendedDateTime.id = KTestVariables.feedbackModel.id;
  PlatformEnumFlutter.isWebDesktop = true;
  mockFaqRepository = MockIFaqRepository();
  mockUserRepository = MockUserRepository();
  mockUrlRepository = MockIUrlRepository();
  mockBuildRepository = MockAppInfoRepository();
  mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
  mockAuthencticationRepository = MockAuthenticationRepository();

  when(mockAuthencticationRepository.currectAuthenticationStatus).thenAnswer(
    (realInvocation) => AuthenticationStatus.anonymous,
  );

  when(mockUserRepository.currentUser).thenAnswer(
    (realInvocation) => User.empty,
  );
  when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
    (invocation) async => const Right(true),
  );
  when(mockBuildRepository.getBuildInfo()).thenAnswer(
    (invocation) async => AppInfoRepository.defaultValue,
  );
  // when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
  //   (realInvocation) => UserSetting.empty,
  // );
  // when(mockAppAuthenticationRepository.currentUser).thenAnswer(
  //   (realInvocation) => KTestVariables.user,
  // );
  when(mockUserRepository.currentUserSetting).thenAnswer(
    (realInvocation) => UserSetting.empty,
  );
  // when(mockUserRepository.isAnonymously).thenAnswer(
  //   (realInvocation) => true,
  // );
  when(
    mockUrlRepository.launchUrl(
      url: KAppText.instagram,
    ),
  ).thenAnswer(
    (realInvocation) async => const Right(
      true,
    ),
  );
  when(
    mockUrlRepository.launchUrl(
      url: KAppText.facebook,
    ),
  ).thenAnswer(
    (realInvocation) async => const Right(
      true,
    ),
  );
  when(
    mockUrlRepository.launchUrl(
      url: KAppText.linkedIn,
    ),
  ).thenAnswer(
    (realInvocation) async => const Right(
      true,
    ),
  );
  when(
    mockFirebaseRemoteConfigProvider
        .getString(AppVersionCubit.mobAppVersionKey),
  ).thenAnswer(
    (_) => KTestVariables.build,
  );
  // mockFeedbackRepository = MockIFeedbackRepository();
  // when(mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel))
  //     .thenAnswer(
  //   (invocation) async => const Right(true),
  // );
  // when(
  //   mockFeedbackRepository.checkUserNeedShowFeedback(KTestVariables.user.
  // id),
  // ).thenAnswer(
  //   (invocation) async => const Right(true),
  // );

  _registerBloc();
}

void _registerBloc() {
  // HomeWatcherBloc
  registerFactory<HomeWatcherBloc>(
    () => HomeWatcherBloc(
      faqRepository: mockFaqRepository,
    ),
  );

  // UserWatcherBloc
  registerFactory<UserWatcherBloc>(
    () => UserWatcherBloc(
      userRepository: mockUserRepository,
    ),
  );

  // AuthenticationBloc
  registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: mockAuthencticationRepository,
    ),
  );

  // UrlCubit
  registerFactory<UrlCubit>(
    () => UrlCubit(
      urlRepository: mockUrlRepository,
    ),
  );

  // AppVersionCubit
  registerFactory<AppVersionCubit>(
    () => AppVersionCubit(
      buildRepository: mockBuildRepository,
      firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    ),
  );
}
