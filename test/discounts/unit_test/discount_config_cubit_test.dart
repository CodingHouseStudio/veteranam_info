import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.discount} Config ${KGroupText.cubit}', () {
    // late DiscountConfigCubit discountConfigCubit;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    const number = 1;

    setUp(() {
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      // discountConfigCubit = DiscountConfigCubit(
      //   firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      // );
      when(
        mockFirebaseRemoteConfigProvider.waitActivated(),
      ).thenAnswer(
        (realInvocation) async {
          await KTestConstants.delay;
          return true;
        },
      );
    });

    group(
        'emits [DiscountConfigState] when '
        'started with default values', () {
      setUp(() {
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
        when(
          mockFirebaseRemoteConfigProvider
              .getBool(DiscountConfigCubit.mobFilterEnhancedMobileKey),
        ).thenAnswer(
          (realInvocation) => false,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getBool(DiscountConfigCubit.enableVerticalDiscountKey),
        ).thenAnswer(
          (realInvocation) => false,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getBool(DiscountConfigCubit.filterShowCountKey),
        ).thenAnswer(
          (realInvocation) => false,
        );

        blocTest<DiscountConfigCubit, DiscountConfigState>(
          'Bloc Test',
          build: () => DiscountConfigCubit(
            firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          ),
          expect: () => <DiscountConfigState>[
            const DiscountConfigState(
              emailScrollCount: KDimensions.emailScrollCount,
              loadingItems: KDimensions.loadItems,
              linkScrollCount: KDimensions.linkScrollCount,
              emailCloseDelay: KDimensions.emailCloseDelay,
              mobFilterEnhancedMobile: false,
              enableVerticalDiscount: false,
              mobileShowCount: false,
            ),
          ],
        );
      });
    });

    group(
        'emits [DiscountConfigState()] when '
        'started with custom values', () {
      setUp(() {
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
        when(
          mockFirebaseRemoteConfigProvider
              .getBool(DiscountConfigCubit.mobFilterEnhancedMobileKey),
        ).thenAnswer(
          (realInvocation) => true,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getBool(DiscountConfigCubit.enableVerticalDiscountKey),
        ).thenAnswer(
          (realInvocation) => true,
        );
        when(
          mockFirebaseRemoteConfigProvider
              .getBool(DiscountConfigCubit.filterShowCountKey),
        ).thenAnswer(
          (realInvocation) => true,
        );
      });
      blocTest<DiscountConfigCubit, DiscountConfigState>(
        'Bloc Test',
        build: () => DiscountConfigCubit(
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        expect: () => [
          const DiscountConfigState(
            emailScrollCount: number,
            loadingItems: number,
            linkScrollCount: number,
            emailCloseDelay: number,
            mobFilterEnhancedMobile: true,
            enableVerticalDiscount: true,
            mobileShowCount: true,
          ),
        ],
      );
    });
  });
}
