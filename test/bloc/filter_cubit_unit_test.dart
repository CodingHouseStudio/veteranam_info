import '../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  // group('${KScreenBlocName.filter} ${KGroupText.cubit}', () {
  //   late FilterCubit filterCubit;
  //   setUp(() => filterCubit = FilterCubit());
  //   blocTest<FilterCubit, List<dynamic>>(
  //     'emits [List<dynamic>] when filter change first index',
  //     build: () => filterCubit,
  //     act: (cubit) async {
  //       cubit.change(index: 0, filterValue: KTestVariables.filter);
  //     },
  //     expect: () async => [
  //       [KTestVariables.filter],
  //     ],
  //   );
  //   blocTest<FilterCubit, List<dynamic>>(
  //     'emits [List<dynamic>] when filter change change second index',
  //     build: () => filterCubit,
  //     act: (cubit) async {
  //       cubit.change(index: 1, filterValue: KTestVariables.filter);
  //     },
  //     expect: () async => [
  //       ['', KTestVariables.filter],
  //     ],
  //   );
  //   blocTest<FilterCubit, List<dynamic>>(
  //     'emits [List<dynamic>] when filter change change first and
  // second index',
  //     build: () => filterCubit,
  //     act: (cubit) async {
  //       cubit
  //         ..change(index: 0, filterValue: KTestVariables.filter)
  //         ..change(index: 1, filterValue: KTestVariables.filter);
  //     },
  //     expect: () async => [
  //       [KTestVariables.filter],
  //       [KTestVariables.filter, KTestVariables.filter],
  //     ],
  //   );
  //   blocTest<FilterCubit, List<dynamic>>(
  //     'emits [List<dynamic>] when filter change change seond and
  // first index',
  //     build: () => filterCubit,
  //     act: (cubit) async {
  //       cubit
  //         ..change(index: 1, filterValue: KTestVariables.filter)
  //         ..change(index: 0, filterValue: KTestVariables.filter);
  //     },
  //     expect: () async => [
  //       ['', KTestVariables.filter],
  //       [KTestVariables.filter, KTestVariables.filter],
  //     ],
  //   );
  //   blocTest<FilterCubit, List<dynamic>>(
  //     'emits [List<dynamic>] when filter change second index and
  // reset filter',
  //     build: () => filterCubit,
  //     act: (cubit) async {
  //       cubit
  //         ..change(index: 1, filterValue: KTestVariables.filter)
  //         ..resetAllValues();
  //     },
  //     expect: () async => [
  //       ['', KTestVariables.filter],
  //       <dynamic>[],
  //     ],
  //   );
  // });
}
