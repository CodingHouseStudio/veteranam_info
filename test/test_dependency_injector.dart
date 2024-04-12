import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import 'text_dependency.dart';

void configureDependenciesTest() {
  // Services
  // Repositories
  GetIt.I.registerSingleton<IInformationRepository>(InformationRepository());
  // Blocs
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
  GetIt.I.registerFactory<LanguageCubit>(LanguageCubit.new);
  GetIt.I.registerFactory<FeedbackBloc>(FeedbackBloc.new);
  GetIt.I.registerSingleton<InformationWatcherBloc>(
    InformationWatcherBloc(
      informationRepository: GetIt.I.get<IInformationRepository>(),
    ),
  );

  final HomeWatcherBloc mockHomeWatcherBloc = MockHomeWatcherBloc();
  when(() => mockHomeWatcherBloc.state).thenReturn(
    const HomeWatcherStateSuccess(
      questionModelItems: KTestText.questionModelItems,
    ),
  );
  GetIt.I.registerSingleton<HomeWatcherBloc>(mockHomeWatcherBloc);
}
