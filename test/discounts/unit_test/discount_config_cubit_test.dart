import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
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
        bloc.started();
      },
      expect: () => [
        const DiscountConfigState(
          emailScrollCount: KDimensions.emailScrollCount,
          loadingItems: KDimensions.loadItems,
          linkScrollCount: KDimensions.linkScrollCount,
          emailCloseDelay: KDimensions.emailCloseDelay,
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
        bloc.started();
      },
      expect: () => [
        const DiscountConfigState(
          emailScrollCount: number,
          loadingItems: number,
          linkScrollCount: number,
          emailCloseDelay: number,
        ),
      ],
    );
  });
}