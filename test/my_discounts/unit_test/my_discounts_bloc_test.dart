import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.myDiscounts} ${KGroupText.bloc}', () {
    late IDiscountRepository mockDiscountRepository;
    late ICompanyRepository mockCompanyRepository;

    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();

      when(
        mockCompanyRepository.currentUserCompany,
      ).thenAnswer(
        (_) => KTestVariables.pureCompanyModel,
      );

      when(
        mockDiscountRepository.deactivateDiscount(
          discountModel: KTestVariables.discountModelItems.first,
        ),
      ).thenAnswer(
        (_) async => const Right(true),
      );
    });

    group(
        'emits [MyDiscountsWatcherState()]'
        ' when get report failure and load nex with listLoadedFull', () {
      group('Without ${KGroupText.stream}', () {
        setUp(
          () => when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestVariables.pureCompanyModel.id),
          ).thenAnswer(
            (_) => Stream.value([KTestVariables.discountModelItems.first]),
          ),
        );
        blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
          'Bloc Test',
          build: () => MyDiscountsWatcherBloc(
            discountRepository: mockDiscountRepository,
            companyRepository: mockCompanyRepository,
          ),
          act: (bloc) async {
            // when(
            //   mockDiscountRepository
            //       .getDiscountsByCompanyId(KTestVariables.
            // pureCompanyModel.id),
            // ).thenAnswer(
            //   (_) => Stream.value([KTestVariables.discountModelItems.first]),
            // );
            // bloc.add(const MyDiscountsWatcherEvent.started());
            await expectLater(
              bloc.stream,
              emitsInOrder([
                predicate<MyDiscountsWatcherState>(
                  (state) => state.loadingStatus == LoadingStatus.loading,
                ),
                // predicate<MyDiscountsWatcherState>(
                //   (state) => state.loadingStatus ==
                // LoadingStatus.listLoadedFull,
                // ),
              ]),
              reason: 'Wait loading data',
            );
            bloc.add(
              const MyDiscountsWatcherEvent.loadNextItems(),
            );
          },
          expect: () => [
            predicate<MyDiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<MyDiscountsWatcherState>(
              (state) => state.isListLoadedFull,
            ),
          ],
        );
      });
      group('emits [loading, error] when there is an error during data loading',
          () {
        setUp(
          () => when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestVariables.pureCompanyModel.id),
          ).thenAnswer(
            (_) => Stream.error(KGroupText.failureGet),
          ),
        );
        blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
          'Bloc Test',
          build: () => MyDiscountsWatcherBloc(
            discountRepository: mockDiscountRepository,
            companyRepository: mockCompanyRepository,
          ),
          // act: (bloc) async {
          //   bloc.add(const MyDiscountsWatcherEvent.started());
          // },
          expect: () => [
            predicate<MyDiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<MyDiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.error,
            ),
          ],
        );
      });
      group(
          'emits [InvestorsWatcherState()]'
          ' when get report failure and load nex with listLoadedFull', () {
        setUp(
          () => when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestVariables.userWithoutPhoto.id),
          ).thenAnswer(
            (_) => Stream.value([KTestVariables.discountModelItems.first]),
          ),
        );
        blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
          'Bloc Test',
          build: () => MyDiscountsWatcherBloc(
            discountRepository: mockDiscountRepository,
            companyRepository: mockCompanyRepository,
          ),
          act: (bloc) async {
            await expectLater(
              bloc.stream,
              emitsInOrder([
                predicate<MyDiscountsWatcherState>(
                  (state) => state.loadingStatus == LoadingStatus.loading,
                ),
                predicate<MyDiscountsWatcherState>(
                  (state) => state.isListLoadedFull,
                ),
              ]),
              reason: 'Wait loading data',
            );
            bloc.add(
              const MyDiscountsWatcherEvent.loadNextItems(),
            );
          },
          expect: () => [
            predicate<MyDiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<MyDiscountsWatcherState>(
              (state) => state.isListLoadedFull,
            ),
          ],
        );
      });
    });
    group('${KGroupText.stream} ', () {
      late StreamController<List<DiscountModel>> discountsStreamController;
      setUp(() {
        discountsStreamController = StreamController<List<DiscountModel>>()
          ..add(KTestVariables.discountModelItems);

        when(
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestVariables.profileUser.id),
        ).thenAnswer((_) => discountsStreamController.stream);

        when(
          mockDiscountRepository
              .deleteDiscountsById(KTestVariables.discountModelItems.first.id),
        ).thenAnswer(
          (_) async {
            discountsStreamController.add(
              KTestVariables.discountModelItems
                  .sublist(1, KTestVariables.discountModelItems.length),
            );
            return const Right(true);
          },
        );
      });
      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [loading, loaded] when data is successfully loaded',
        build: () => MyDiscountsWatcherBloc(
          discountRepository: mockDiscountRepository,
          companyRepository: mockCompanyRepository,
        ),
        // act: (bloc) async => bloc.add(const
        // MyDiscountsWatcherEvent.started()),
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
        ],
      );

      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [MyDiscountsWatcherState()]'
        ' when load DiscountModel list and loadNextItems it',
        build: () => MyDiscountsWatcherBloc(
          discountRepository: mockDiscountRepository,
          companyRepository: mockCompanyRepository,
        ),
        act: (bloc) async {
          // bloc.add(const MyDiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc.add(
            const MyDiscountsWatcherEvent.loadNextItems(),
          );
        },
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.loadedDiscountsModelItems.length ==
                    KDimensions.loadItems &&
                state.itemsLoaded == KDimensions.loadItems,
            // &&
            // state.reportItems.isNotEmpty,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loading &&
                state.loadedDiscountsModelItems.length ==
                    KDimensions.loadItems &&
                state.itemsLoaded == KDimensions.loadItems,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.loadedDiscountsModelItems.length ==
                    KDimensions.loadItems * 2 &&
                state.itemsLoaded == KDimensions.loadItems * 2,
          ),
        ],
      );

      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits updated state when a discount is successfully deleted',
        build: () => MyDiscountsWatcherBloc(
          discountRepository: mockDiscountRepository,
          companyRepository: mockCompanyRepository,
        ),
        act: (bloc) async {
          // bloc.add(const MyDiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );

          bloc.add(
            MyDiscountsWatcherEvent.deleteDiscount(
              KTestVariables.discountModelItems.first.id,
            ),
          );
        },
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.discountsModelItems.any(
                  (discount) =>
                      discount.id != KTestVariables.discountModelItems.first.id,
                ),
          ),
        ],
      );

      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits error state when there is an error during discount deletion',
        build: () => MyDiscountsWatcherBloc(
          discountRepository: mockDiscountRepository,
          companyRepository: mockCompanyRepository,
        ),
        act: (bloc) async {
          when(
            mockDiscountRepository.deleteDiscountsById(
              KTestVariables.discountModelItems.first.id,
            ),
          ).thenAnswer(
            (_) async => const Left(SomeFailure.serverError),
          );

          // bloc.add(const MyDiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc.add(
            MyDiscountsWatcherEvent.deleteDiscount(
              KTestVariables.discountModelItems.first.id,
            ),
          );
        },
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.failure != null,
          ),
        ],
      );

      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [MyDiscountsWatcherState()] when like',
        build: () => MyDiscountsWatcherBloc(
          discountRepository: mockDiscountRepository,
          companyRepository: mockCompanyRepository,
        ),
        act: (bloc) async {
          // bloc.add(const MyDiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc.add(
            MyDiscountsWatcherEvent.changeDeactivate(
              KTestVariables.discountModelItems.first,
            ),
          );
        },
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
        ],
      );

      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [MyDiscountsWatcherState()] when change like',
        build: () => MyDiscountsWatcherBloc(
          discountRepository: mockDiscountRepository,
          companyRepository: mockCompanyRepository,
        ),
        act: (bloc) async {
          // bloc.add(const MyDiscountsWatcherEvent.started());

          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc.add(
            MyDiscountsWatcherEvent.changeDeactivate(
              KTestVariables.discountModelItems.first,
            ),
          );
        },
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
        ],
      );

      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [MyDiscountsWatcherState()] when change like failure',
        build: () => MyDiscountsWatcherBloc(
          discountRepository: mockDiscountRepository,
          companyRepository: mockCompanyRepository,
        ),
        act: (bloc) async {
          when(
            mockDiscountRepository.deactivateDiscount(
              discountModel: KTestVariables.discountModelItems.first,
            ),
          ).thenAnswer(
            (_) async => const Left(SomeFailure.serverError),
          );

          // bloc.add(const MyDiscountsWatcherEvent.started());

          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc.add(
            MyDiscountsWatcherEvent.changeDeactivate(
              KTestVariables.discountModelItems.first,
            ),
          );
        },
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.error,
          ),
        ],
      );
      tearDown(() async => discountsStreamController.close());
    });
  });
}
