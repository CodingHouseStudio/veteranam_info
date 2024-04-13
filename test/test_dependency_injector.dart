import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

void configureDependenciesTest() {
  // Services
  GetIt.I.registerSingleton<FakeClient>(FakeClient());
  GetIt.I.registerFactory<FirestoreService>(
    FirestoreService.new,
  );

  // Repositories
  GetIt.I.registerSingleton<IFeedbackRepository>(FeedbackRepository());
  GetIt.I.registerSingleton<IHomeRepository>(HomeRepository());
  GetIt.I.registerSingleton<IInformationRepository>(InformationRepository());
  // Blocs
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
  GetIt.I.registerFactory<LanguageCubit>(LanguageCubit.new);
  GetIt.I.registerSingleton<FeedbackBloc>(
    FeedbackBloc(feedbackRepository: GetIt.I.get<IFeedbackRepository>()),
  );
  GetIt.I.registerSingleton<HomeWatcherBloc>(
    HomeWatcherBloc(homeRepository: GetIt.I.get<IHomeRepository>()),
  );
  GetIt.I.registerSingleton<InformationWatcherBloc>(
    InformationWatcherBloc(
      informationRepository: GetIt.I.get<IInformationRepository>(),
    ),
  );
}
