import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.investors} ${KGroupText.repository} ', () {
    late IInvestorsRepository investorsRepository;
    late FirestoreService mockFirestoreService;

    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        ExtendedDateTime.id = '';
        mockFirestoreService = MockFirestoreService();

        when(mockFirestoreService.getFunds()).thenAnswer(
          (_) async => KTestText.fundItems,
        );
        when(
          mockFirestoreService.addFund(KTestText.fundItems.first),
        ).thenAnswer(
          (realInvocation) async {},
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        investorsRepository = InvestorsRepository();
      });
      test('questions', () async {
        expect(
          await investorsRepository.getFunds(),
          isA<Right<SomeFailure, List<FundModel>>>()
              .having((e) => e.value, 'value', KTestText.fundItems),
        );
      });
      test('mock', () async {
        investorsRepository.addMockFunds();
        verify(
          mockFirestoreService.addFund(KTestText.fundItems.first),
        ).called(1);
      });
    });

    group('${KGroupText.failureGet} ', () {
      setUp(() {
        mockFirestoreService = MockFirestoreService();

        when(mockFirestoreService.getFunds()).thenThrow(
          KGroupText.failureGet,
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        investorsRepository = InvestorsRepository();
      });
      test('questions', () async {
        expect(
          await investorsRepository.getFunds(),
          isA<Left<SomeFailure, List<FundModel>>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
    });
  });
}
