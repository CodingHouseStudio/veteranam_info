import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.workEmployee} ', () {
    group('${KGroupText.model} ', () {
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.workModelItems.first.id,
          'title': KTestText.workModelItems.first.title,
          'price': KTestText.workModelItems.first.price,
          'employerContact': KTestText.workModelItems.first.employerContact,
          'companyName': KTestText.workModelItems.first.companyName,
          'description': KTestText.workModelItems.first.description,
          'category': KTestText.workModelItems.first.category,
          'city': KTestText.workModelItems.first.city,
          'remote': KTestText.workModelItems.first.remote,
        };

        final workModel = WorkModel.fromJson(json);

        expect(
          workModel.id,
          KTestText.workModelItems.first.id,
        );
        expect(
          workModel.title,
          KTestText.workModelItems.first.title,
        );
        expect(
          workModel.category,
          KTestText.workModelItems.first.category,
        );
        expect(
          workModel.city,
          KTestText.workModelItems.first.city,
        );
        expect(
          workModel.companyName,
          KTestText.workModelItems.first.companyName,
        );
        expect(
          workModel.description,
          KTestText.workModelItems.first.description,
        );
        expect(
          workModel.employerContact,
          KTestText.workModelItems.first.employerContact,
        );
        expect(
          workModel.price,
          KTestText.workModelItems.first.price,
        );
        expect(
          workModel.remote,
          KTestText.workModelItems.first.remote,
        );
      });

      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.workModelItems.first.id,
          'title': KTestText.workModelItems.first.title,
          'price': KTestText.workModelItems.first.price,
          'employerContact': KTestText.workModelItems.first.employerContact,
          'companyName': KTestText.workModelItems.first.companyName,
          'description': KTestText.workModelItems.first.description,
        };

        final workModel = WorkModel.fromJson(json);

        expect(
          workModel.id,
          KTestText.workModelItems.first.id,
        );
        expect(
          workModel.title,
          KTestText.workModelItems.first.title,
        );
        expect(
          workModel.category,
          null,
        );
        expect(
          workModel.city,
          null,
        );
        expect(
          workModel.companyName,
          KTestText.workModelItems.first.companyName,
        );
        expect(
          workModel.description,
          KTestText.workModelItems.first.description,
        );
        expect(
          workModel.employerContact,
          KTestText.workModelItems.first.employerContact,
        );
        expect(
          workModel.price,
          KTestText.workModelItems.first.price,
        );
        expect(
          workModel.remote,
          false,
        );
      });

      test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
        final json = {
          'title': KTestText.workModelItems.first.title,
          'price': KTestText.workModelItems.first.price,
          'employerContact': KTestText.workModelItems.first.employerContact,
          'companyName': KTestText.workModelItems.first.companyName,
          'description': KTestText.workModelItems.first.description,
        };

        expect(
          () => WorkModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.repository} ', () {
      late IWorkRepository mockWorkRepository;
      group('${KGroupText.successfulGet} ', () {
        setUp(() {
          mockWorkRepository = MockIWorkRepository();
          when(mockWorkRepository.getWorks()).thenAnswer(
            (_) => Stream.value(KTestText.workModelItems),
          );
        });
        test('Work', () async {
          expect(
            mockWorkRepository.getWorks(),
            emits(KTestText.workModelItems),
          );
        });
      });
      group('${KGroupText.failureGet} ', () {
        setUp(() {
          mockWorkRepository = MockIWorkRepository();
          when(mockWorkRepository.getWorks()).thenAnswer(
            (_) => Stream.error(KGroupText.failureGet),
          );
        });
        test('information', () async {
          expect(
            mockWorkRepository.getWorks(),
            emitsError(KGroupText.failureGet),
          );
        });
      });
    });

    group('${KScreenBlocName.workEmployeeBloc} ', () {
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
            (_) => Stream.value(KTestText.workModelItems),
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
            (_) => Stream.value(KTestText.workModelItems),
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
              cities: KTestText.workModelItems.first.city,
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
                state.categories == null &&
                state.cities == null,
          ),
          predicate<WorkEmployeeWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredWorkModelItems.isNotEmpty &&
                state.filteredWorkModelItems.first.city!.contains(
                  KTestText.workModelItems.first.city!,
                ) &&
                state.categories == null,
          ),
        ],
      );

      blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
        'emits [WorkEmployeeWatcherState()]'
        ' when load workModel list and loadPage 5',
        build: () => workEmployeeWatcherBloc,
        act: (bloc) async {
          when(mockWorkRepository.getWorks()).thenAnswer(
            (_) => Stream.value(KTestText.workModelItems),
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
            (_) => Stream.value(KTestText.workModelItems),
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
            (_) => Stream.value(KTestText.workModelItems),
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
            WorkEmployeeWatcherEvent.loadPage(KTestText.workModelItems.length),
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
            (_) => Stream.value(KTestText.workModelItems),
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
              categories: KTestText.workModelItems.first.category,
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
                state.categories == null &&
                state.cities == null,
          ),
          predicate<WorkEmployeeWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredWorkModelItems.isNotEmpty &&
                state.filteredWorkModelItems.first.category!.contains(
                  KTestText.workModelItems.first.category!,
                ) &&
                state.cities == null,
          ),
        ],
      );

      blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
        'emits [WorkEmployeeWatcherState()] when loading'
        ' workModel list and filtering use category, city and reset filters',
        build: () => workEmployeeWatcherBloc,
        act: (bloc) async {
          when(mockWorkRepository.getWorks()).thenAnswer(
            (_) => Stream.value(KTestText.workModelItems),
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
                categories: KTestText.workModelItems.first.category,
              ),
            )
            ..add(
              WorkEmployeeWatcherEvent.filterCities(
                cities: KTestText.workModelItems.first.city,
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
                state.categories == null &&
                state.cities == null,
          ),
          predicate<WorkEmployeeWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredWorkModelItems.isNotEmpty &&
                state.filteredWorkModelItems.first.category!.contains(
                  KTestText.workModelItems.first.category!,
                ) &&
                state.cities == null,
          ),
          predicate<WorkEmployeeWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredWorkModelItems.isNotEmpty &&
                state.filteredWorkModelItems.first.category!.contains(
                  KTestText.workModelItems.first.category!,
                ) &&
                state.filteredWorkModelItems.first.city!.contains(
                  KTestText.workModelItems.first.city!,
                ),
          ),
          predicate<WorkEmployeeWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredWorkModelItems.isNotEmpty &&
                state.categories == null &&
                state.cities == null,
          ),
        ],
      );

      blocTest<WorkEmployeeWatcherBloc, WorkEmployeeWatcherState>(
        'emits [WorkEmployeeWatcherState()]'
        ' when load workModel list and loadPage 1',
        build: () => workEmployeeWatcherBloc,
        act: (bloc) async {
          when(mockWorkRepository.getWorks()).thenAnswer(
            (_) => Stream.value(KTestText.workModelItems),
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
  });
}
