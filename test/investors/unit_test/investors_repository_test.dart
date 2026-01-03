// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.investors} ${KGroupText.repository} ', () {
    late IInvestorsRepository investorsRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      mockFirestoreService = MockFirestoreService();
    });

    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockFirestoreService.getFunds(//null
              ),
        ).thenAnswer(
          (_) async => KTestVariables.fundItems,
        );
        when(
          mockFirestoreService.addFund(KTestVariables.fundItems.first),
        ).thenAnswer(
          (realInvocation) async {},
        );

        investorsRepository =
            InvestorsRepository(firestoreService: mockFirestoreService);
      });
      test('funds', () async {
        expect(
          await investorsRepository.getFunds(),
          isA<Right<SomeFailure, List<FundModel>>>()
              .having((e) => e.value, 'value', KTestVariables.fundItems),
        );
      });
      test('mock', () async {
        investorsRepository.addMockFunds();
        verify(
          mockFirestoreService.addFund(
            KTestVariables.fundItems.first,
          ),
        ).called(1);
      });
    });

    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockFirestoreService.getFunds(//null
              ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );

        investorsRepository =
            InvestorsRepository(firestoreService: mockFirestoreService);
      });
      test('Get funds', () async {
        expect(
          await investorsRepository.getFunds(),
          isA<Left<SomeFailure, List<FundModel>>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
    });

    // group('${KGroupText.firebaseFailure} ', () {
    //   setUp(() {
    //     when(
    //       mockFirestoreService.getFunds(//null,
    //           ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failureGet),
    //     );

    //     investorsRepository =
    //         InvestorsRepository(firestoreService: mockFirestoreService);
    //   });
    //   test('Get funds', () async {
    //     expect(
    //       await investorsRepository.getFunds(),
    //       isA<Left<SomeFailure, List<FundModel>>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });
    // });
  });
}
