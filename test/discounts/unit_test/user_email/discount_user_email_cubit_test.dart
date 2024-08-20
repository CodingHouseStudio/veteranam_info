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
  group('${KScreenBlocName.discount} Email ${KGroupText.bloc}', () {
    late DiscountUserEmailCubit discountUserEmailCubit;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
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
      );
    });

    blocTest<DiscountUserEmailCubit, bool>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountUserEmailCubit,
      act: (bloc) async => bloc.started(),
      expect: () async => [
        true,
      ],
    );

    blocTest<DiscountUserEmailCubit, bool>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountUserEmailCubit,
      act: (bloc) async {
        when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
            .thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        await bloc.started();
      },
      expect: () async => [
        false,
      ],
    );
  });
}
