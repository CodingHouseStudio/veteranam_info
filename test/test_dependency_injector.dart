import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';

void configureDependenciesTest() {
  // Blocs
  GetIt.I.registerFactory<FilterCubit>(FilterCubit.new);
}
