import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.discount} ${KGroupText.bloc}', () {
    late IDiscountRepository mockdiscountRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      when(
        mockFirebaseRemoteConfigProvider.getBool(
          RemoteConfigKey.showOnlyBusinessDiscounts,
        ),
      ).thenAnswer(
        (_) => false,
      );
      when(
        mockdiscountRepository.getDiscount(
          id: KTestVariables.id,
          showOnlyBusinessDiscounts: false,
        ),
      ).thenAnswer(
        (_) async => Right(KTestVariables.fullDiscount),
      );
    });

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [DiscountWatcherState()]'
      ' when load discountModel correct',
      build: () => DiscountWatcherBloc(
        discountRepository: mockdiscountRepository,
        discountId: KTestVariables.id,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        discount: null,
      ),
      act: (bloc) async {
        await KTestConstants.delay;
        bloc.add(
          const DiscountWatcherEvent.started(
            KTestVariables.id,
          ),
        );
        // bloc
        //   ..add(const DiscountWatcherEvent.started(''))
        //   ..add(
        //     DiscountWatcherEvent.started(
        //       KTestVariables.fullDiscount.id,
        //     ),
        //   );
      },
      expect: () async => [
        DiscountWatcherState(
          discountModel: KMockText.discountModel,
          loadingStatus: LoadingStatus.loading,
        ),
        DiscountWatcherState(
          discountModel: KTestVariables.fullDiscount,
          loadingStatus: LoadingStatus.loaded,
        ),
        DiscountWatcherState(
          discountModel: KTestVariables.fullDiscount,
          loadingStatus: LoadingStatus.loading,
        ),
        DiscountWatcherState(
          discountModel: KTestVariables.fullDiscount,
          loadingStatus: LoadingStatus.loaded,
        ),
      ],
    );

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [DiscountWatcherState()]'
      ' when load discountModel with wrong id',
      build: () => DiscountWatcherBloc(
        discountRepository: mockdiscountRepository,
        discountId: '',
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        discount: null,
      ),
      // act: (bloc) async {
      //   await KTestConstants.delay;
      // },
      expect: () async => [
        DiscountWatcherState(
          discountModel: KMockText.discountModel,
          loadingStatus: LoadingStatus.error,
          failure: SomeFailure.linkWrong,
        ),
      ],
    );

    group('${KGroupText.failure} ', () {
      setUp(
        () => when(
          mockdiscountRepository.getDiscount(
            id: KTestVariables.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        ),
      );

      blocTest<DiscountWatcherBloc, DiscountWatcherState>(
        'emits [DiscountWatcherState()]'
        ' when load discountModel ${KGroupText.failure}',
        build: () => DiscountWatcherBloc(
          discountRepository: mockdiscountRepository,
          discountId: KTestVariables.id,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          discount: null,
        ),
        expect: () async => [
          DiscountWatcherState(
            discountModel: KMockText.discountModel,
            loadingStatus: LoadingStatus.loading,
          ),
          DiscountWatcherState(
            discountModel: KMockText.discountModel,
            loadingStatus: LoadingStatus.error,
            failure: SomeFailure.linkWrong,
          ),
        ],
      );
    });
  });
}
