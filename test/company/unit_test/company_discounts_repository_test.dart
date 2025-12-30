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

  group('${KScreenBlocName.discount} ${KGroupText.repository} ', () {
    late IDiscountRepository mockDiscountRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockFirestoreService = MockFirestoreService();
    });

    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscount(
            id: KTestVariables.userWithoutPhoto.id,
            companyId: KTestVariables.fullCompanyModel.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer((_) async => KTestVariables.discountModelItems.first);

        when(
          mockFirestoreService.companyHasDiscounts(
            KTestVariables.fullCompanyModel.id,
          ),
        ).thenAnswer((_) async => true);

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });

      test('Get company discounts', () async {
        expect(
          await mockDiscountRepository.getCompanyDiscount(
            id: KTestVariables.userWithoutPhoto.id,
            companyId: KTestVariables.fullCompanyModel.id,
          ),
          isA<Right<SomeFailure, DiscountModel>>().having(
            (e) => e.value,
            'value',
            KTestVariables.discountModelItems.first,
          ),
        );
      });

      test('Company has discounts', () async {
        final result = await mockDiscountRepository.companyHasDiscount(
          KTestVariables.fullCompanyModel.id,
        );
        expect(
          result,
          isTrue,
        );
      });
    });

    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscount(
            id: KTestVariables.userWithoutPhoto.id,
            companyId: KTestVariables.fullCompanyModel.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        when(
          mockFirestoreService.companyHasDiscounts(
            KTestVariables.fullCompanyModel.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });

      test('Get company discounts failure', () async {
        expect(
          await mockDiscountRepository.getCompanyDiscount(
            id: KTestVariables.userWithoutPhoto.id,
            companyId: KTestVariables.fullCompanyModel.id,
          ),
          isA<Left<SomeFailure, DiscountModel>>(),
        );
      });

      test('Company has discounts failure', () async {
        expect(
          await mockDiscountRepository.companyHasDiscount(
            KTestVariables.fullCompanyModel.id,
          ),
          isTrue,
        );
      });
    });

    // group('${KGroupText.firebaseFailure} ', () {
    //   setUp(() {
    //     when(
    //       mockFirestoreService.getDiscount(
    //         id: KTestVariables.userWithoutPhoto.id,
    //         companyId: KTestVariables.fullCompanyModel.id,
    //         showOnlyBusinessDiscounts: false,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failure),
    //     );

    //     mockDiscountRepository =
    //         DiscountRepository(firestoreService: mockFirestoreService);
    //   });

    //   test('Get company discounts firebaseError', () async {
    //     expect(
    //       await mockDiscountRepository.getCompanyDiscount(
    //         id: KTestVariables.userWithoutPhoto.id,
    //         companyId: KTestVariables.fullCompanyModel.id,
    //       ),
    //       isA<Left<SomeFailure, DiscountModel>>(),
    //     );
    //   });
    // });
  });
}
