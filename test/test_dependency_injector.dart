import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import 'text_dependency.dart';

void configureDependenciesTest() {
  // Services
  // Repositories
  // Blocs
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
  GetIt.I.registerFactory<LanguageCubit>(LanguageCubit.new);
  GetIt.I.registerSingleton<FeedbackBloc>(FeedbackBloc());

  final HomeWatcherBloc mockHomeWatcherBloc = MockHomeWatcherBloc();
  when(() => mockHomeWatcherBloc.state).thenReturn(
    const HomeWatcherStateSuccess(
      questionModelItems: KTestText.questionModelItems,
    ),
  );
  GetIt.I.registerSingleton<HomeWatcherBloc>(mockHomeWatcherBloc);
}
