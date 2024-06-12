import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} ${KGroupText.repository} ', () {
    late IDiscountRepository mockDiscountRepository;
    late FirestoreService mockFirestoreService;

    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        ExtendedDateTime.id = '';
        ExtendedDateTime.current = KTestText.dateTime;
        mockFirestoreService = MockFirestoreService();
        mockDiscountRepository = MockIDiscountRepository();

        when(
          mockFirestoreService
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (_) async => KTestText.discountModelItems,
        );
        when(
          mockDiscountRepository
              .getDiscountsById(KTestText.userWithoutPhoto.id),
        ).thenAnswer(
          (_) async => Right(KTestText.discountModelItems),
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
    });

    group('${KGroupText.failureGet} ', () {
      setUp(() {
        mockFirestoreService = MockFirestoreService();

        when(
          mockFirestoreService
              .getDiscountsByUserId(KTestText.userWithoutPhoto.id),
        ).thenThrow(
          Exception(KGroupText.failureGet),
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
    });

    group('${KGroupText.successfulDelete} ', () {
      setUp(() {
        mockFirestoreService = MockFirestoreService();

        when(
          mockFirestoreService
              .deleteDiscountById(KTestText.discountModelItems.first.id),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockDiscountRepository
              .deleteDiscountsById(KTestText.discountModelItems.first.id),
        ).thenAnswer(
          (_) async => const Right(unit),
        );

        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
      });

      test('Delete by discount ID', () async {
        expect(
          await mockDiscountRepository.deleteDiscountsById(
            KTestText.discountModelItems.first.id,
          ),
          isA<Right<SomeFailure, Unit>>().having((e) => e.value, 'value', unit),
        );
      });
    });

    group('${KGroupText.failureDelete} ', () {
      setUp(() {
        when(
          mockFirestoreService.deleteDiscountById(
            KTestText.discountModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureDelete),
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
          isA<Left<SomeFailure, Unit>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
    });
  });
}
