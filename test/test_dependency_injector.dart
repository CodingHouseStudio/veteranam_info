import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import 'text_dependency.dart';

/// COMMENT: Method register Services, Repositories and Blocs in tests
void configureDependenciesTest() {
  // register logic if user id empty user setting is also empty
  userSetting();
  // Services
  GetIt.I.registerSingleton<FirebaseAuth>(MockFirebaseAuth());
  GetIt.I.registerSingleton<GoogleSignIn>(GoogleSignIn());
  GetIt.I.registerSingleton<FakeClient>(FakeClient());
  GetIt.I.registerFactory<FirestoreService>(
    FirestoreService.new,
  );
  GetIt.I.registerSingleton<StorageService>(
    MockStorageService(),
  );
  // Repositories
  GetIt.I.registerLazySingleton<IStorage>(SecureStorageRepository.new);
  GetIt.I.registerSingleton<IFeedbackRepository>(FeedbackRepository());
  GetIt.I.registerSingleton<IHomeRepository>(HomeRepository());
  GetIt.I.registerSingleton<IAppAuthenticationRepository>(
    AppAuthenticationRepository(
      GetIt.I.get<IStorage>(),
      GetIt.I.get<FirebaseAuth>(),
      GetIt.I.get<GoogleSignIn>(),
      CacheClient(),
    ),
  );
  GetIt.I.registerSingleton<AuthenticationRepository>(
    AuthenticationRepository(
      GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<IInformationRepository>(InformationRepository());
  GetIt.I.registerSingleton<IInvestorsRepository>(InvestorsRepository());
  GetIt.I.registerSingleton<IWorkRepository>(WorkRepository());
  GetIt.I.registerSingleton<IStoryRepository>(StoryRepository());
  // Blocs
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
  GetIt.I.registerSingleton<FeedbackBloc>(
    FeedbackBloc(feedbackRepository: GetIt.I.get<IFeedbackRepository>()),
  );
  GetIt.I.registerSingleton<HomeWatcherBloc>(
    HomeWatcherBloc(homeRepository: GetIt.I.get<IHomeRepository>()),
  );
  GetIt.I.registerSingleton<AuthenticationBloc>(
    AuthenticationBloc(
      authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<LoginBloc>(
    LoginBloc(
      authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<SignUpBloc>(
    SignUpBloc(
      iAppAuthenticationRepository: GetIt.I.get<IAppAuthenticationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<InformationWatcherBloc>(
    InformationWatcherBloc(
      informationRepository: GetIt.I.get<IInformationRepository>(),
    ),
  );
  GetIt.I.registerSingleton<InvestorsWatcherBloc>(
    InvestorsWatcherBloc(
      investorsRepository: GetIt.I.get<IInvestorsRepository>(),
    ),
  );
  GetIt.I.registerSingleton<WorkEmployeeWatcherBloc>(
    WorkEmployeeWatcherBloc(
      workRepository: GetIt.I.get<IWorkRepository>(),
    ),
  );
  GetIt.I.registerSingleton<StoryWatcherBloc>(
    StoryWatcherBloc(
      storyRepository: GetIt.I.get<IStoryRepository>(),
    ),
  );
}
