import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'text_dependency.dart';

void configureDependenciesTest() {
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
  GetIt.I.registerSingleton<LanguageCubit>(LanguageCubit());
  GetIt.I.registerFactory<SharedPreferences>(MockSharedPreferences.new);
}
