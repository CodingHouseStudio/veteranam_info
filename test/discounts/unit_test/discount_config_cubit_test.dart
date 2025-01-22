import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} Config ${KGroupText.cubit}', () {
    late DiscountConfigCubit discountConfigCubit;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    const number = 1;

    setUp(() {
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      discountConfigCubit = DiscountConfigCubit(
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      );
    });

    blocTest<DiscountConfigCubit, DiscountConfigState>(
      'emits [AdvancedFilterMobState()] when '
      'location filer and sorting',
      build: () => discountConfigCubit,
      act: (bloc) {
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.loadingItemsKey),
        ).thenAnswer(
          (realInvocation) => 0,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.emailCloseDelayKey),
        ).thenAnswer(
          (realInvocation) => 0,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.emailScrollKey),
        ).thenAnswer(
          (realInvocation) => 0,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.linkScrollKey),
        ).thenAnswer(
          (realInvocation) => 0,
        );
      },
      expect: () => <DiscountConfigState>[
        const DiscountConfigState(
          emailScrollCount: KDimensions.emailScrollCount,
          loadingItems: KDimensions.loadItems,
          linkScrollCount: KDimensions.linkScrollCount,
          emailCloseDelay: KDimensions.emailCloseDelay,
          mobFilterEnhancedMobile: false,
          enableVerticalDiscount: false,
        ),
      ],
    );

    blocTest<DiscountConfigCubit, DiscountConfigState>(
      'emits [AdvancedFilterMobState()] when '
      'location filer and sorting',
      build: () => discountConfigCubit,
      act: (bloc) {
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.loadingItemsKey),
        ).thenAnswer(
          (realInvocation) => number,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.emailCloseDelayKey),
        ).thenAnswer(
          (realInvocation) => number,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.emailScrollKey),
        ).thenAnswer(
          (realInvocation) => number,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountConfigCubit.linkScrollKey),
        ).thenAnswer(
          (realInvocation) => number,
        );
      },
      expect: () => [
        const DiscountConfigState(
          emailScrollCount: number,
          loadingItems: number,
          linkScrollCount: number,
          emailCloseDelay: number,
          mobFilterEnhancedMobile: false,
          enableVerticalDiscount: false,
        ),
      ],
    );
  });
}
