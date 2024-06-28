import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.myDiscounts} ${KGroupText.bloc}', () {
    late MyDiscountsWatcherBloc myDiscountsWatcherBloc;
    late IDiscountRepository mockDiscountRepository;
    late IAppAuthenticationRepository mockAuthRepository;

    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      mockAuthRepository = MockIAppAuthenticationRepository();
      when(mockAuthRepository.currentUser)
          .thenAnswer((invocation) => KTestText.userWithoutPhoto);
      when(
        mockDiscountRepository.getDiscountsById(KTestText.userWithoutPhoto.id),
      ).thenAnswer((_) async => Right(KTestText.discountModelItems));

      when(
        mockDiscountRepository
            .deleteDiscountsById(KTestText.discountModelItems.first.id),
      ).thenAnswer(
        (_) async => const Right(true),
      );
      myDiscountsWatcherBloc = MyDiscountsWatcherBloc(
        discountRepository: mockDiscountRepository,
        iAppAuthenticationRepository: mockAuthRepository,
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
      'emits updated state when a discount is successfully deleted',
      build: () => myDiscountsWatcherBloc,
      act: (bloc) async => bloc
        ..add(const MyDiscountsWatcherEvent.started())
        ..add(
          MyDiscountsWatcherEvent.deleteDiscount(
            KTestText.discountModelItems.first.id,
          ),
        ),
      expect: () => [
        predicate<MyDiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<MyDiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        predicate<MyDiscountsWatcherState>(
          (state) => !state.discountsModelItems.any(
            (discount) => discount.id == KTestText.discountModelItems.first.id,
          ),
        ),
      ],
    );

    blocTest<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
      'emits [loading, error] when there is an error during data loading',
      build: () => myDiscountsWatcherBloc,
      act: (bloc) async {
        when(
          mockDiscountRepository
              .getDiscountsById(KTestText.userWithoutPhoto.id),
        ).thenAnswer((_) async => const Left(SomeFailure.serverError()));
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
      'emits error state when there is an error during discount deletion',
      build: () => myDiscountsWatcherBloc,
      act: (bloc) async {
        when(
          mockDiscountRepository
              .deleteDiscountsById(KTestText.discountModelItems.first.id),
        ).thenAnswer((_) async => const Left(SomeFailure.serverError()));
        bloc
          ..add(const MyDiscountsWatcherEvent.started())
          ..add(
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
          (state) => state.loadingStatus == LoadingStatus.error,
        ),
      ],
    );
  });
}
