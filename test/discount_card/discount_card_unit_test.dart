import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_cubit.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discountCard} ${KGroupText.bloc}', () {
    late DiscountCardWatcherCubit discountCardWatcherCubit;
    late IDiscountRepository mockdiscountRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      discountCardWatcherCubit = DiscountCardWatcherCubit(
        discountRepository: mockdiscountRepository,
      );
    });

    blocTest<DiscountCardWatcherCubit, DiscountCardWatcherState>(
      'emits [DiscountCardWatcherState()]'
      ' when load discountModel with wrong id and correct',
      build: () => discountCardWatcherCubit,
      act: (bloc) async {
        when(
          mockdiscountRepository.getDiscount(
            id: KTestText.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (_) async => Right(KTestText.discountModelItems.first),
        );
        // bloc
        //   ..add(const DiscountCardWatcherEvent.started(''))
        //   ..add(
        //     DiscountCardWatcherEvent.started(
        //       KTestText.discountModelItems.first.id,
        //     ),
        //   );
      },
      expect: () async => [
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.error,
          failure: DiscountCardFailure.wrongID,
        ),
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        DiscountCardWatcherState(
          discountModel: KTestText.discountModelItems.first,
          loadingStatus: LoadingStatus.loaded,
          failure: null,
        ),
      ],
    );

    blocTest<DiscountCardWatcherCubit, DiscountCardWatcherState>(
      'emits [DiscountCardWatcherState()]'
      ' when load discountModel ${KGroupText.failure}',
      build: () => discountCardWatcherCubit,
      act: (bloc) async {
        when(
          mockdiscountRepository.getDiscount(
            id: KTestText.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        // bloc.add(
        //   DiscountCardWatcherEvent.started(
        //     KTestText.discountModelItems.first.id,
        //   ),
        // );
      },
      expect: () async => [
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.error,
          failure: DiscountCardFailure.error,
        ),
      ],
    );
  });
}
