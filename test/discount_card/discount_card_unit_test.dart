import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_cubit.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.discountCard} ${KGroupText.bloc}', () {
    late IDiscountRepository mockdiscountRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      when(
        mockdiscountRepository.getDiscount(
          id: KTestVariables.discountModelItems.first.id,
          showOnlyBusinessDiscounts: false,
        ),
      ).thenAnswer(
        (_) async {
          await KTestConstants.delay;
          return Right(KTestVariables.discountModelItems.first);
        },
      );
    });

    blocTest<DiscountCardWatcherCubit, DiscountCardWatcherState>(
      'emits [DiscountCardWatcherState()]'
      ' when load discountModel with wrong id and correct',
      build: () => DiscountCardWatcherCubit(
        discountRepository: mockdiscountRepository,
        id: KTestVariables.discountModelItems.first.id,
      ),
      act: (bloc) async {
        await KTestConstants.delay;
        await bloc.onStarted(id: KTestVariables.discountModelItems.first.id);
        await bloc.onStarted(id: '');
        // bloc
        //   ..add(const DiscountCardWatcherEvent.started(''))
        //   ..add(
        //     DiscountCardWatcherEvent.started(
        //       KTestVariables.discountModelItems.first.id,
        //     ),
        //   );
      },
      expect: () async => [
        DiscountCardWatcherState(
          discountModel: KTestVariables.discountModelItems.first,
          loadingStatus: LoadingStatus.loaded,
          failure: null,
        ),
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        DiscountCardWatcherState(
          discountModel: KTestVariables.discountModelItems.first,
          loadingStatus: LoadingStatus.loaded,
          failure: null,
        ),
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.error,
          failure: SomeFailure.wrongID,
        ),
      ],
    );

    group('${KGroupText.failure} ', () {
      setUp(
        () => when(
          mockdiscountRepository.getDiscount(
            id: KTestVariables.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (_) async {
            await KTestConstants.delay;
            return const Left(SomeFailure.serverError);
          },
        ),
      );

      blocTest<DiscountCardWatcherCubit, DiscountCardWatcherState>(
        'emits [DiscountCardWatcherState()]'
        ' when load discountModel ${KGroupText.failure}',
        build: () => DiscountCardWatcherCubit(
          discountRepository: mockdiscountRepository,
          id: '',
        ),
        // act: (bloc) async {
        //   await bloc.onStarted(id: KTestVariables.discountModelItems.
        // first.id);
        //   // bloc.add(
        //   //   DiscountCardWatcherEvent.started(
        //   //     KTestVariables.discountModelItems.first.id,
        //   //   ),
        //   // );
        // },
        // expect: () async => [
        // const DiscountCardWatcherState(
        //   discountModel: null,
        //   loadingStatus: LoadingStatus.loading,
        //   failure: null,
        // ),
        // const DiscountCardWatcherState(
        //   discountModel: null,
        //   loadingStatus: LoadingStatus.error,
        //   failure: DiscountCardFailure.error,
        // ),
        // ],
      );
    });
  });
}
