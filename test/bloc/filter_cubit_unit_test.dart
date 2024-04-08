import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group(KScreenBlocName.filterCubit, () {
    late FilterCubit filterCubit;
    setUp(() => filterCubit = FilterCubit());
    blocTest<FilterCubit, List<dynamic>>(
      'emits [List<dynamic>] when filter change first index',
      build: () => filterCubit,
      act: (cubit) async {
        cubit.change(index: 0, filterValue: KTestText.filter);
      },
      expect: () async => [
        [KTestText.filter],
      ],
    );
    blocTest<FilterCubit, List<dynamic>>(
      'emits [List<dynamic>] when filter change change second index',
      build: () => filterCubit,
      act: (cubit) async {
        cubit.change(index: 1, filterValue: KTestText.filter);
      },
      expect: () async => [
        ['', KTestText.filter],
      ],
    );
    blocTest<FilterCubit, List<dynamic>>(
      'emits [List<dynamic>] when filter change change first and second index',
      build: () => filterCubit,
      act: (cubit) async {
        cubit
          ..change(index: 0, filterValue: KTestText.filter)
          ..change(index: 1, filterValue: KTestText.filter);
      },
      expect: () async => [
        [KTestText.filter],
        [KTestText.filter, KTestText.filter],
      ],
    );
    blocTest<FilterCubit, List<dynamic>>(
      'emits [List<dynamic>] when filter change change seond and first index',
      build: () => filterCubit,
      act: (cubit) async {
        cubit
          ..change(index: 1, filterValue: KTestText.filter)
          ..change(index: 0, filterValue: KTestText.filter);
      },
      expect: () async => [
        ['', KTestText.filter],
        [KTestText.filter, KTestText.filter],
      ],
    );
    blocTest<FilterCubit, List<dynamic>>(
      'emits [List<dynamic>] when filter change second index and reset filter',
      build: () => filterCubit,
      act: (cubit) async {
        cubit
          ..change(index: 1, filterValue: KTestText.filter)
          ..resetAllValues();
      },
      expect: () async => [
        ['', KTestText.filter],
        <dynamic>[],
      ],
    );
  });
}
