import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} Email ${KGroupText.cubit}', () {
    late DiscountUserEmailCubit discountUserEmailCubit;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();

      when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
          .thenAnswer(
        (_) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      discountUserEmailCubit = DiscountUserEmailCubit(
        discountRepository: mockdiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      );
    });

    blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
      'emits [DiscountUserEmailState()] when '
      'check need to show and get emailScrollCount',
      build: () => discountUserEmailCubit,
      act: (bloc) async {
        when(
          mockFirebaseRemoteConfigProvider
              .getInt(DiscountUserEmailCubit.emailScrollKey),
        ).thenAnswer(
          (invocation) => KDimensions.loadItems,
        );
        await bloc.started();
      },
      expect: () async => [
        const DiscountUserEmailState(
          show: true,
          emailScrollCount: KDimensions.loadItems,
        ),
      ],
    );

    blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
      'emits [DiscountUserEmailState()] when '
      'check need to show failure and get emailScrollCount == 0',
      build: () => discountUserEmailCubit,
      act: (bloc) async {
        when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
            .thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        await bloc.started();
      },
      expect: () async => [
        const DiscountUserEmailState(
          show: false,
          emailScrollCount: KDimensions.emailScrollCount,
        ),
      ],
    );
  });
}
