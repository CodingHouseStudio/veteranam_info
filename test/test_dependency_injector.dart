import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import 'text_dependency.dart';

void configureDependenciesTest() {
  // Services
  GetIt.I.registerSingleton<FakeClient>(FakeClient());
  GetIt.I.registerFactory<FirestoreService>(
    FirestoreService.new,
  );

  // Repositories
  GetIt.I.registerSingleton<IFeedbackRepository>(FeedbackRepository());
  // Blocs
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
  GetIt.I.registerFactory<LanguageCubit>(LanguageCubit.new);
  GetIt.I.registerSingleton<FeedbackBloc>(
    FeedbackBloc(feedbackRepository: GetIt.I.get<IFeedbackRepository>()),
  );

  final HomeWatcherBloc mockHomeWatcherBloc = MockHomeWatcherBloc();
  when(() => mockHomeWatcherBloc.state).thenReturn(
    const HomeWatcherStateSuccess(
      questionModelItems: KTestText.questionModelItems,
    ),
  );
  GetIt.I.registerSingleton<HomeWatcherBloc>(mockHomeWatcherBloc);
}
