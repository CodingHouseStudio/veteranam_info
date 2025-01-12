// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mockito/mockito.dart';
// import 'package:veteranam/components/components.dart';
// import 'package:veteranam/shared/shared.dart';

// import '../../../test_dependency.dart';

void main() {
  // setUp(configureFailureDependenciesTest);

  // setupFirebaseAuthMocks();

  // setUpAll(setUpGlobal);

  // tearDown(GetIt.I.reset);
  // group('${KScreenBlocName.discount} Email ${KGroupText.cubit}', () {
  //   late DiscountUserEmailCubit discountUserEmailCubit;
  //   late IDiscountRepository mockdiscountRepository;
  //   late IAppAuthenticationRepository mockAppAuthenticationRepository;
  //   // late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

  //   setUp(() {
  //     mockdiscountRepository = MockIDiscountRepository();
  //     mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
  //     // mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();

  //     // when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
  //     //     .thenAnswer(
  //     //   (_) async => const Right(0),
  //     // );
  //     when(mockAppAuthenticationRepository.currentUser).thenAnswer(
  //       (invocation) => KTestText.user,
  //     );
  //     discountUserEmailCubit = DiscountUserEmailCubit(
  //       discountRepository: mockdiscountRepository,
  //       appAuthenticationRepository: mockAppAuthenticationRepository,
  //       // firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  //     );
  //   });

  //   blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
  //     'emits [UserEmailPropery()] when '
  //     'check need to show first time',
  //     build: () => discountUserEmailCubit,
  //     act: (bloc) async {
  //       when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
  //           .thenAnswer(
  //         (_) async => const Right(0),
  //       );
  //       await bloc.started();
  //     },
  //     expect: () async => [
  //       const DiscountUserEmailState(
  //         UserEmailEnum.discountEmailAbandon,
  //         count: 0,
  //       ),
  //     ],
  //   );

  //   blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
  //     'emits [UserEmailPropery()] when '
  //     'check need to show first time',
  //     build: () => discountUserEmailCubit,
  //     act: (bloc) async {
  //       when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
  //           .thenAnswer(
  //         (_) async => const Right(1),
  //       );
  //       await bloc.started();
  //     },
  //     expect: () async => [
  //       const DiscountUserEmailState(
  //         UserEmailEnum.discountEmailAbandonSecondary,
  //         count: 1,
  //       ),
  //     ],
  //   );
  //   blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
  //     'emits [UserEmailPropery()] when '
  //     'check need to show first time',
  //     build: () => discountUserEmailCubit,
  //     act: (bloc) async {
  //       when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
  //           .thenAnswer(
  //         (_) async => const Right(2),
  //       );
  //       await bloc.started();
  //     },
  //     expect: () async => [
  //       const DiscountUserEmailState(
  //         UserEmailEnum.discountEmailAbandonRepeat,
  //         count: 2,
  //       ),
  //     ],
  //   );
  //   blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
  //     'emits [UserEmailPropery()] when '
  //     'check need to show first time',
  //     build: () => discountUserEmailCubit,
  //     act: (bloc) async {
  //       when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
  //           .thenAnswer(
  //         (_) async => const Right(5),
  //       );
  //       await bloc.started();
  //     },
  //     expect: () async => [
  //       const DiscountUserEmailState(
  //         UserEmailEnum.discountEmailAbandonRepeat,
  //         count: 5,
  //       ),
  //     ],
  //   );
  //   blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
  //     'emits [UserEmailPropery()] when '
  //     'check need to show first time',
  //     build: () => discountUserEmailCubit,
  //     act: (bloc) async {
  //       when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
  //           .thenAnswer(
  //         (_) async => const Right(-1),
  //       );
  //       await bloc.started();
  //     },
  //     expect: () async => [
  //       const DiscountUserEmailState(
  //         UserEmailEnum.discountEmailNotShow,
  //         count: -1,
  //       ),
  //     ],
  //   );
  //   blocTest<DiscountUserEmailCubit, DiscountUserEmailState>(
  //     'emits [UserEmailPropery()] when '
  //     'check need to show first time',
  //     build: () => discountUserEmailCubit,
  //     act: (bloc) async {
  //       when(mockdiscountRepository.userCanSendUserEmail(KTestText.user.id))
  //           .thenAnswer(
  //         (_) async => const Left(SomeFailure.serverError),
  //       );
  //       await bloc.started();
  //     },
  //     expect: () async => [
  //       const DiscountUserEmailState(
  //         UserEmailEnum.discountEmailNotShow,
  //       ),
  //     ],
  //   );
  // });
}
