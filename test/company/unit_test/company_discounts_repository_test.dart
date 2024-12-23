import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.discount} ${KGroupText.repository} ', () {
    late IDiscountRepository mockDiscountRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      ExtendedDateTime.current = KTestText.dateTime;
      mockFirestoreService = MockFirestoreService();
    });

    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscount(
            id: KTestText.userWithoutPhoto.id,
            companyId: KTestText.fullCompanyModel.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer((_) async => KTestText.discountModelItems.first);

        when(
          mockFirestoreService.companyHasDiscounts(
            KTestText.fullCompanyModel.id,
          ),
        ).thenAnswer((_) async => true);

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });

      test('Get company discounts', () async {
        expect(
          await mockDiscountRepository.getCompanyDiscount(
            id: KTestText.userWithoutPhoto.id,
            companyId: KTestText.fullCompanyModel.id,
          ),
          isA<Right<SomeFailure, DiscountModel>>().having(
            (e) => e.value,
            'value',
            KTestText.discountModelItems.first,
          ),
        );
      });

      test('Company has discounts', () async {
        final result = await mockDiscountRepository.companyHasDiscount(
          KTestText.fullCompanyModel.id,
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
            id: KTestText.userWithoutPhoto.id,
            companyId: KTestText.fullCompanyModel.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        when(
          mockFirestoreService.companyHasDiscounts(
            KTestText.fullCompanyModel.id,
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
            id: KTestText.userWithoutPhoto.id,
            companyId: KTestText.fullCompanyModel.id,
          ),
          isA<Left<SomeFailure, DiscountModel>>(),
        );
      });

      test('Company has discounts failure', () async {
        expect(
          await mockDiscountRepository.companyHasDiscount(
            KTestText.fullCompanyModel.id,
          ),
          isTrue,
        );
      });
    });

    group('${KGroupText.firebaseFailure} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscount(
            id: KTestText.userWithoutPhoto.id,
            companyId: KTestText.fullCompanyModel.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failure),
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });

      test('Get company discounts firebaseError', () async {
        expect(
          await mockDiscountRepository.getCompanyDiscount(
            id: KTestText.userWithoutPhoto.id,
            companyId: KTestText.fullCompanyModel.id,
          ),
          isA<Left<SomeFailure, DiscountModel>>(),
        );
      });
    });
  });
}
