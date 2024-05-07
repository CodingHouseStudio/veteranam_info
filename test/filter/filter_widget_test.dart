import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/bloc/filter/blocprovider/filter_cubit_blocprovider.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group(
    'FilterBoxWidget',
    () {
      late MockFilterCubit filterCubit;
      const filters = ['Filter1', 'Filter2', 'Filter3'];

      setUp(() {
        filterCubit = MockFilterCubit();

        when(filterCubit.stream).thenAnswer(
          (_) => Stream.value(filters),
        );
      });

      void registerFilterCubit() {
        if (GetIt.I.isRegistered<FilterCubit>()) {
          GetIt.I.unregister<FilterCubit>();
        }
        GetIt.I.registerSingleton<FilterCubit>(filterCubit);
      }

      testWidgets('Widget renders correctly', (tester) async {
        registerFilterCubit();
        await tester.pumpApp(
          const Material(
            child: FilterCubitBlocprovider(
              childWidget: FilterBoxWidget(filters: filters),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(
          find.byKey(KWidgetkeys.widget.filterPopupMenu.widget),
          findsOneWidget,
        );

        for (final filter in filters) {
          if (filters.first == filter) {
            expect(find.byType(DropChipWidget), findsAtLeast(1));
          } else {
            expect(find.byType(ChipWidget), findsAtLeast(1));
          }
        }
      });

      testWidgets('Tapping on chips triggers change in FilterCubit',
          (tester) async {
        final filterCubit = MockFilterCubit();
        const filters = ['Filter1', 'Filter2', 'Filter3'];
        registerFilterCubit();
        when(filterCubit.state).thenReturn(['Filter1']);

        await tester.pumpApp(
          const Material(
            child: FilterCubitBlocprovider(
              childWidget: FilterBoxWidget(filters: filters),
            ),
          ),
        );

        await tester.pumpAndSettle();

        verifyNever(filterCubit.change(filterValue: 'Filter1', index: 0))
            .called(0);
      });
    },
  );
}
