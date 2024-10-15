import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

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
          mockFirestoreService.getDiscounts(
            userId: KTestText.userWithoutPhoto.id,
          ),
        ).thenAnswer(
          (_) => Stream.value(KTestText.discountModelItems),
        );

        when(
          mockFirestoreService.updateDiscountModel(
            KTestText.discountModelItems.first
                .copyWith(status: DiscountState.deactivated),
          ),
        ).thenAnswer((_) async {});

        when(
          mockFirestoreService.updateDiscountModel(
            KTestText.discountModelItems.first,
          ),
        ).thenAnswer((_) async {});

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
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestText.userWithoutPhoto.id),
          emits(KTestText.discountModelItems),
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

      test('Deactivate discount', () async {
        expect(
          await mockDiscountRepository.deactivateDiscount(
            discountModel: KTestText.discountModelItems.first,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });

      test('Deactivate discount', () async {
        expect(
          await mockDiscountRepository.deactivateDiscount(
            discountModel: KTestText.discountModelItems.first
                .copyWith(status: DiscountState.deactivated),
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
    });

    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscounts(
            userId: KTestText.userWithoutPhoto.id,
          ),
        ).thenAnswer((_) => Stream.error(KGroupText.failureGet));
        when(
          mockFirestoreService.deleteDiscountById(
            KTestText.discountModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failure),
        );
        when(
          mockFirestoreService.updateDiscountModel(
            KTestText.discountModelItems.first
                .copyWith(status: DiscountState.deactivated),
          ),
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
      });

      test('Get by user ID Failure', () async {
        expect(
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestText.userWithoutPhoto.id),
          emitsError(KGroupText.failureGet),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Delete by discount ID Failure', () async {
        expect(
          await mockDiscountRepository.deleteDiscountsById(
            KTestText.discountModelItems.first.id,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });

      test('Deactivate discount failure', () async {
        expect(
          await mockDiscountRepository.deactivateDiscount(
            discountModel: KTestText.discountModelItems.first,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
    });

    group('${KGroupText.firebaseFailure} ', () {
      setUp(() {
        when(
          mockFirestoreService.deleteDiscountById(
            KTestText.discountModelItems.first.id,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failure),
        );
        when(
          mockFirestoreService.updateDiscountModel(
            KTestText.discountModelItems.first
                .copyWith(status: DiscountState.deactivated),
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

      test('Delete by discount ID Failure', () async {
        expect(
          await mockDiscountRepository.deleteDiscountsById(
            KTestText.discountModelItems.first.id,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });

      test('Deactivate discount failure', () async {
        expect(
          await mockDiscountRepository.deactivateDiscount(
            discountModel: KTestText.discountModelItems.first,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
    });
  });
}
