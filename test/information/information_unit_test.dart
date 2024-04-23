import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.information} ', () {
    group('${KGroupText.model} ', () {
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.informationModelItems.elementAt(0).id,
          'title': KTestText.informationModelItems.elementAt(0).title,
          'news': KTestText.informationModelItems.elementAt(0).news,
          'date': KTestText.informationModelItems
              .elementAt(0)
              .date
              .toIso8601String(),
          'tags': KTestText.informationModelItems.elementAt(0).tags,
          'image': KTestText.informationModelItems.elementAt(0).image,
        };

        final informationModel = InformationModel.fromJson(json);

        expect(
          informationModel.id,
          KTestText.informationModelItems.elementAt(0).id,
        );
        expect(
          informationModel.title,
          KTestText.informationModelItems.elementAt(0).title,
        );
        expect(
          informationModel.news,
          KTestText.informationModelItems.elementAt(0).news,
        );
        expect(
          informationModel.date,
          KTestText.informationModelItems.elementAt(0).date,
        );
        expect(
          informationModel.image,
          KTestText.informationModelItems.elementAt(0).image,
        );
        expect(
          informationModel.tags,
          KTestText.informationModelItems.elementAt(0).tags,
        );
      });

      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.informationModelItems.elementAt(0).id,
          'title': KTestText.informationModelItems.elementAt(0).title,
          'news': KTestText.informationModelItems.elementAt(0).news,
          'date': KTestText.informationModelItems
              .elementAt(0)
              .date
              .toIso8601String(),
        };

        final informationModel = InformationModel.fromJson(json);

        expect(
          informationModel.id,
          KTestText.informationModelItems.elementAt(0).id,
        );
        expect(
          informationModel.title,
          KTestText.informationModelItems.elementAt(0).title,
        );
        expect(
          informationModel.news,
          KTestText.informationModelItems.elementAt(0).news,
        );
        expect(
          informationModel.date,
          KTestText.informationModelItems.elementAt(0).date,
        );
        expect(
          informationModel.image,
          null,
        );
        expect(
          informationModel.tags,
          <String>[],
        );
      });

      test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.informationModelItems.elementAt(0).id,
          // title is missing
          'news': KTestText.informationModelItems.elementAt(0).news,
          'date': KTestText.informationModelItems
              .elementAt(0)
              .date
              .toIso8601String(),
        };

        expect(
          () => InformationModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.repository} ', () {
      late IInformationRepository mockInformationRepository;
      group('${KGroupText.successfulGet} ', () {
        setUp(() {
          mockInformationRepository = MockIInformationRepository();
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.value(KTestText.informationModelItems),
          );
        });
        test('information', () async {
          expect(
            mockInformationRepository.getInformationItems(),
            emits(KTestText.informationModelItems),
          );
        });
      });
      group('${KGroupText.failureGet} ', () {
        setUp(() {
          mockInformationRepository = MockIInformationRepository();
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.error(KGroupText.failureGet),
          );
        });
        test('information', () async {
          expect(
            mockInformationRepository.getInformationItems(),
            emitsError(KGroupText.failureGet),
          );
        });
      });
    });

    group('${KScreenBlocName.informationBloc} ', () {
      late InformationWatcherBloc informationWatcherBloc;
      late IInformationRepository mockInformationRepository;

      setUp(() {
        mockInformationRepository = MockIInformationRepository();
        informationWatcherBloc = InformationWatcherBloc(
          informationRepository: mockInformationRepository,
        );
      });

      blocTest<InformationWatcherBloc, InformationWatcherState>(
        'emits [InformationWatcherState()]'
        ' when load informationModel list',
        build: () => informationWatcherBloc,
        act: (bloc) async {
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.value(KTestText.informationModelItems),
          );
          bloc.add(const InformationWatcherEvent.started());
        },
        expect: () async => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
        ],
      );
      blocTest<InformationWatcherBloc, InformationWatcherState>(
        'emits [InformationWatcherState()] when error',
        build: () => informationWatcherBloc,
        act: (bloc) async {
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.error(KGroupText.failureGet),
          );
          bloc.add(const InformationWatcherEvent.started());
        },
        expect: () async => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.error &&
                state.failure != null,
          ),
        ],
      );

      blocTest<InformationWatcherBloc, InformationWatcherState>(
        'emits [InformationWatcherState()] when loading'
        ' informationModel list and filtering it',
        build: () => informationWatcherBloc,
        act: (bloc) async {
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.value(KTestText.informationModelItems),
          );
          bloc.add(const InformationWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait for loading data',
          );
          bloc.add(
            InformationWatcherEvent.filter(
              filter: KTestText.informationModelItems.elementAt(1).tags!.first,
            ),
          );
        },
        /*expect: () => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.isEmpty &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.isNotEmpty &&
                state.filteredInformationModelItems.first.tags!.contains(
                  KTestText.informationModelItems.elementAt(1).tags!.first,
                ) &&
                state.filters == null,
          ),
        ],*/
      );

      blocTest<InformationWatcherBloc, InformationWatcherState>(
        'emits [InformationWatcherState()]'
        ' when load informationModel list and loadNextItems it',
        build: () => informationWatcherBloc,
        act: (bloc) async {
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.value(KTestText.informationModelItems),
          );
          bloc.add(const InformationWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc.add(
            const InformationWatcherEvent.loadNextItems(),
          );
        },
        expect: () => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.length == 1 &&
                state.itemsLoaded == 1,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.length == 2 &&
                state.itemsLoaded == 2,
          ),
        ],
      );
      blocTest<InformationWatcherBloc, InformationWatcherState>(
        'emits [InformationWatcherState()]'
        ' when load informationModel list, loadNextItems and filter it',
        build: () => informationWatcherBloc,
        act: (bloc) async {
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.value(KTestText.informationModelItems),
          );
          bloc.add(const InformationWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc
            ..add(
              const InformationWatcherEvent.loadNextItems(),
            )
            ..add(
              InformationWatcherEvent.filter(
                filter:
                    KTestText.informationModelItems.elementAt(1).tags!.first,
              ),
            );
        },
        /*expect: () => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) !=
                    KTestText.informationModelItems.elementAt(1) &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.length == 2 &&
                state.itemsLoaded == 2 &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) ==
                    KTestText.informationModelItems.elementAt(1) &&
                state.filters != null &&
                state.itemsLoaded == 1,
          ),
        ],*/
      );
      blocTest<InformationWatcherBloc, InformationWatcherState>(
        'emits [InformationWatcherState()]'
        ' when load informationModel list, filter, loadNextItems,none filter'
        ' and loadNextItems it',
        build: () => informationWatcherBloc,
        act: (bloc) async {
          when(mockInformationRepository.getInformationItems()).thenAnswer(
            (_) => Stream.value(KTestText.informationModelItems),
          );
          bloc.add(const InformationWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<InformationWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc
            ..add(
              InformationWatcherEvent.filter(
                filter:
                    KTestText.informationModelItems.elementAt(1).tags!.first,
              ),
            )
            ..add(
              const InformationWatcherEvent.loadNextItems(),
            )
            ..add(
              const InformationWatcherEvent.filter(),
            )
            ..add(
              const InformationWatcherEvent.loadNextItems(),
            );
        },
        /* expect: () => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) !=
                    KTestText.informationModelItems.elementAt(1) &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) ==
                    KTestText.informationModelItems.elementAt(1) &&
                state.filters != null &&
                state.itemsLoaded == 1,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) ==
                    KTestText.informationModelItems.elementAt(0) &&
                state.filters == null &&
                state.itemsLoaded == 1,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                // Ensure the filtered item is the first one
                state.filteredInformationModelItems.length == 2 &&
                // Ensure itemsLoaded is updated and filters are null
                state.itemsLoaded == 2 &&
                state.filters == null,
          ),
        ],*/
      );
    });
  });
}
