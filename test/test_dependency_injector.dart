import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';

void configureDependenciesTest() {
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
  GetIt.I.registerSingleton<LanguageCubit>(LanguageCubit());
}
