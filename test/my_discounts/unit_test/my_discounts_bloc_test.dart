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
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.myDiscounts} ${KGroupText.bloc}', () {
    late MyDiscountsWatcherBloc myDiscountsWatcherBloc;
    late IDiscountRepository mockDiscountRepository;
    late ICompanyRepository mockCompanyRepository;

    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();

      when(
        mockCompanyRepository.currentUserCompany,
      ).thenAnswer(
        (_) => const CompanyModel(id: '1', userEmails: []),
      );

      when(
        mockDiscountRepository.deactivateDiscount(
          discountModel: KTestText.discountModelItems.first,
        ),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      myDiscountsWatcherBloc = MyDiscountsWatcherBloc(
        discountRepository: mockDiscountRepository,
        companyRepository: mockCompanyRepository,
      );
    });

    group('Without ${KGroupText.stream}', () {
      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [MyDiscountsWatcherState()]'
        ' when get report failure and load nex with listLoadedFull',
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestText.userWithoutPhoto.id),
          ).thenAnswer(
            (_) => Stream.value([KTestText.discountModelItems.first]),
          );
          bloc.add(const MyDiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.listLoadedFull,
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
            (state) => state.loadingStatus == LoadingStatus.listLoadedFull,
          ),
        ],
      );
      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [loading, error] when there is an error during data loading',
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestText.userWithoutPhoto.id),
          ).thenAnswer(
            (_) => Stream.error(KGroupText.failureGet),
          );
          bloc.add(const MyDiscountsWatcherEvent.started());
        },
        expect: () => [
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MyDiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.error,
          ),
        ],
      );
      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [InvestorsWatcherState()]'
        ' when get report failure and load nex with listLoadedFull',
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          when(
            mockDiscountRepository
                .getDiscountsByCompanyId(KTestText.userWithoutPhoto.id),
          ).thenAnswer(
            (_) => Stream.value([KTestText.discountModelItems.first]),
          );
          bloc.add(const MyDiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<MyDiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.listLoadedFull,
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
            (state) => state.loadingStatus == LoadingStatus.listLoadedFull,
          ),
        ],
      );
    });
    group('${KGroupText.stream} ', () {
      late StreamController<List<DiscountModel>> discountsStreamController;
      setUp(() {
        discountsStreamController = StreamController<List<DiscountModel>>()
          ..add(KTestText.discountModelItems);

        when(
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestText.profileUser.id),
        ).thenAnswer((_) => discountsStreamController.stream);

        when(
          mockDiscountRepository
              .deleteDiscountsById(KTestText.discountModelItems.first.id),
        ).thenAnswer(
          (_) async {
            discountsStreamController.add(
              KTestText.discountModelItems
                  .sublist(1, KTestText.discountModelItems.length),
            );
            return const Right(true);
          },
        );
      });
      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits [loading, loaded] when data is successfully loaded',
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async => bloc.add(const MyDiscountsWatcherEvent.started()),
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
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          bloc.add(const MyDiscountsWatcherEvent.started());
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
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          bloc.add(const MyDiscountsWatcherEvent.started());
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
              KTestText.discountModelItems.first.id,
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
                      discount.id != KTestText.discountModelItems.first.id,
                ),
          ),
        ],
      );

      blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
        'emits error state when there is an error during discount deletion',
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          when(
            mockDiscountRepository
                .deleteDiscountsById(KTestText.discountModelItems.first.id),
          ).thenAnswer(
            (_) async => Left(SomeFailure.serverError(error: null)),
          );

          bloc.add(const MyDiscountsWatcherEvent.started());
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
              KTestText.discountModelItems.first.id,
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
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          bloc.add(const MyDiscountsWatcherEvent.started());
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
              KTestText.discountModelItems.first,
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
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          bloc.add(const MyDiscountsWatcherEvent.started());

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
              KTestText.discountModelItems.first,
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
        build: () => myDiscountsWatcherBloc,
        act: (bloc) async {
          when(
            mockDiscountRepository.deactivateDiscount(
              discountModel: KTestText.discountModelItems.first,
            ),
          ).thenAnswer(
            (_) async => Left(SomeFailure.serverError(error: null)),
          );

          bloc.add(const MyDiscountsWatcherEvent.started());

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
              KTestText.discountModelItems.first,
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
