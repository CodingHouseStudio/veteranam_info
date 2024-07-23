import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} Link ${KGroupText.bloc}', () {
    late DiscountLinkCubit discountLinkCubit;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockdiscountRepository.userCanSendLink(KTestText.user.id))
          .thenAnswer(
        (_) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      discountLinkCubit = DiscountLinkCubit(
        discountRepository: mockdiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<DiscountLinkCubit, bool>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountLinkCubit,
      act: (bloc) async => bloc.started(),
      expect: () async => [
        true,
      ],
    );

    blocTest<DiscountLinkCubit, bool>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountLinkCubit,
      act: (bloc) async {
        when(mockdiscountRepository.userCanSendLink(KTestText.user.id))
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
