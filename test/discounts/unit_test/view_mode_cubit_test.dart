import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/discounts/bloc/bloc.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('Advanced Filter Mob ${KGroupText.cubit}', () {
    late ViewModeCubit viewModeCubit;

    setUp(() {
      viewModeCubit = ViewModeCubit();
    });

    blocTest<ViewModeCubit, ViewMode>(
      'emits [ViewMode] when changed',
      build: () => viewModeCubit,
      act: (bloc) => bloc
        ..setGridView()
        ..setGridView()
        ..setListView()
        ..setListView(),
      expect: () => [
        ViewMode.grid,
        ViewMode.list,
      ],
    );
  });
}
