import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.discount} Link ${KGroupText.bloc}', () {
    late DiscountLinkCubit discountLinkCubit;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockdiscountRepository.userCanSendLink(KTestVariables.user.id))
          .thenAnswer(
        (_) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestVariables.user,
      );
      discountLinkCubit = DiscountLinkCubit(
        discountRepository: mockdiscountRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<DiscountLinkCubit, bool>(
      'emits [bool]'
      ' when user can send link',
      build: () => discountLinkCubit,
      act: (bloc) async => bloc.started(),
      expect: () async => <bool>[],
    );

    blocTest<DiscountLinkCubit, bool>(
      'emits [bool]'
      " when user can't send link",
      build: () => discountLinkCubit,
      act: (bloc) async {
        when(mockdiscountRepository.userCanSendLink(KTestVariables.user.id))
            .thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        await bloc.started();
      },
      expect: () async => [
        false,
      ],
    );
  });
}
