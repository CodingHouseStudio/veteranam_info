import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
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
          mockFirestoreService
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (_) async => KTestText.discountModelItems,
        );
        when(
          mockFirestoreService
              .deleteDiscountById(KTestText.discountModelItems.first.id),
        ).thenAnswer(
          (_) async {},
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
      });

      test('Get by user ID', () async {
        expect(
          await mockDiscountRepository
              .getDiscountsById(KTestText.userWithoutPhoto.id),
          isA<Right<SomeFailure, List<DiscountModel>>>()
              .having((e) => e.value, 'value', KTestText.discountModelItems),
        );
      });

      test('Delete by discount ID', () async {
        expect(
          await mockDiscountRepository.deleteDiscountsById(
            KTestText.discountModelItems.first.id,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
    });

    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockFirestoreService
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureGet),
        );
        when(
          mockFirestoreService.deleteDiscountById(
            KTestText.discountModelItems.first.id,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failure),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
      });

      test('Get by user ID Failure', () async {
        expect(
          await mockDiscountRepository
              .getDiscountsById(KTestText.userWithoutPhoto.id),
          isA<Left<SomeFailure, List<DiscountModel>>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
      test('Delete by discount ID Failure', () async {
        expect(
          await mockDiscountRepository.deleteDiscountsById(
            KTestText.discountModelItems.first.id,
          ),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
    });
  });
}
