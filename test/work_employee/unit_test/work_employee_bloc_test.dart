import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.workEmployee} ${KGroupText.bloc}', () {
    late WorkEmployeeWatcherBloc workEmployeeWatcherBloc;
    late IWorkRepository mockWorkRepository;

    setUp(() {
      mockWorkRepository = MockIWorkRepository();
      workEmployeeWatcherBloc = WorkEmployeeWatcherBloc(
        workRepository: mockWorkRepository,
      );
    });

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()]'
      ' when load workModel list',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
      },
      expect: () async => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()] when error',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.error(KGroupText.failureGet),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
      },
      expect: () async => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.error &&
              state.failure != null,
        ),
      ],
    );

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()] when loading'
      ' workModel list and filtering use city',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc.add(
          WorkEmployeeWatcherEvent.filterCities(
            city: KTestVariables.workModelItems.first.city,
          ),
        );
      },
      expect: () => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.category == null &&
              state.city == null,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.filteredWorkModelItems.first.city!.contains(
                KTestVariables.workModelItems.first.city!,
              ) &&
              state.category == null,
        ),
      ],
    );

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()]'
      ' when load workModel list and loadPage 5',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const WorkEmployeeWatcherEvent.loadPage(5),
        );
      },
      expect: () => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded && state.page == 1,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded && state.page == 5,
        ),
      ],
    );

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()]'
      ' when load workModel list and loadPage 0',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const WorkEmployeeWatcherEvent.loadPage(0),
        );
      },
      expect: () => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded && state.page == 1,
        ),
      ],
    );

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()]'
      ' when load workModel list and loadPage KTestText.workModelItems.'
      ' length',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          WorkEmployeeWatcherEvent.loadPage(
            KTestVariables.workModelItems.length,
          ),
        );
      },
      expect: () => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded && state.page == 1,
        ),
      ],
    );

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()] when loading'
      ' workModel list and filtering use category',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc.add(
          WorkEmployeeWatcherEvent.filterCategories(
            category: KTestVariables.workModelItems.first.category,
          ),
        );
      },
      expect: () => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.category == null &&
              state.city == null,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.filteredWorkModelItems.first.category!.contains(
                KTestVariables.workModelItems.first.category!,
              ) &&
              state.city == null,
        ),
      ],
    );

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()] when loading'
      ' workModel list and filtering use category, city and reset filters',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(
            WorkEmployeeWatcherEvent.filterCategories(
              category: KTestVariables.workModelItems.first.category,
            ),
          )
          ..add(
            WorkEmployeeWatcherEvent.filterCities(
              city: KTestVariables.workModelItems.first.city,
            ),
          )
          ..add(
            const WorkEmployeeWatcherEvent.filterReset(),
          );
      },
      expect: () => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.category == null &&
              state.city == null,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.filteredWorkModelItems.first.category!.contains(
                KTestVariables.workModelItems.first.category!,
              ) &&
              state.city == null,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.filteredWorkModelItems.first.category!.contains(
                KTestVariables.workModelItems.first.category!,
              ) &&
              state.filteredWorkModelItems.first.city!.contains(
                KTestVariables.workModelItems.first.city!,
              ),
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredWorkModelItems.isNotEmpty &&
              state.category == null &&
              state.city == null,
        ),
      ],
    );

    blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
      'emits [WorkEmployeeWatcherState()]'
      ' when load workModel list and loadPage 1',
      build: () => workEmployeeWatcherBloc,
      act: (bloc) async {
        when(mockWorkRepository.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        bloc.add(const WorkEmployeeWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<WorkEmployeeWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const WorkEmployeeWatcherEvent.loadPage(1),
        );
      },
      expect: () => [
        predicate<WorkEmployeeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<WorkEmployeeWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded && state.page == 1,
        ),
      ],
    );
  });
}
