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
          mockFirestoreService.getDiscounts(
            userId: KTestVariables.userWithoutPhoto.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (_) => Stream.value(KTestVariables.discountModelItems),
        );

        when(
          mockFirestoreService.updateDiscountModel(
            KTestVariables.discountModelItems.first
                .copyWith(status: DiscountState.deactivated),
          ),
        ).thenAnswer((_) async {});

        when(
          mockFirestoreService.updateDiscountModel(
            KTestVariables.discountModelItems.first,
          ),
        ).thenAnswer((_) async {});

        when(
          mockFirestoreService
              .deleteDiscountById(KTestVariables.discountModelItems.first.id),
        ).thenAnswer(
          (_) async {},
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });

      test('Get by user ID', () async {
        expect(
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestVariables.userWithoutPhoto.id),
          emits(KTestVariables.discountModelItems),
        );
      });

      test('Delete by discount ID', () async {
        expect(
          await mockDiscountRepository.deleteDiscountsById(
            KTestVariables.discountModelItems.first.id,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });

      test('Deactivate discount', () async {
        expect(
          await mockDiscountRepository.deactivateDiscount(
            discountModel: KTestVariables.discountModelItems.first,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });

      test('Deactivate discount', () async {
        expect(
          await mockDiscountRepository.deactivateDiscount(
            discountModel: KTestVariables.discountModelItems.first
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
            userId: KTestVariables.userWithoutPhoto.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer((_) => Stream.error(KGroupText.failureGet));
        when(
          mockFirestoreService.deleteDiscountById(
            KTestVariables.discountModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failure),
        );
        when(
          mockFirestoreService.updateDiscountModel(
            KTestVariables.discountModelItems.first
                .copyWith(status: DiscountState.deactivated),
          ),
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });

      test('Get by user ID Failure', () async {
        expect(
          mockDiscountRepository
              .getDiscountsByCompanyId(KTestVariables.userWithoutPhoto.id),
          emitsError(KGroupText.failureGet),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Delete by discount ID Failure', () async {
        expect(
          await mockDiscountRepository.deleteDiscountsById(
            KTestVariables.discountModelItems.first.id,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });

      test('Deactivate discount failure', () async {
        expect(
          await mockDiscountRepository.deactivateDiscount(
            discountModel: KTestVariables.discountModelItems.first,
          ),
          isA<Left<SomeFailure, bool>>(),
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
    //       mockFirestoreService.deleteDiscountById(
    //         KTestVariables.discountModelItems.first.id,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failure),
    //     );
    //     when(
    //       mockFirestoreService.updateDiscountModel(
    //         KTestVariables.discountModelItems.first
    //             .copyWith(status: DiscountState.deactivated),
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failure),
    //     );

    //     mockDiscountRepository =
    //         DiscountRepository(firestoreService: mockFirestoreService);
    //   });

    //   test('Delete by discount ID Failure', () async {
    //     expect(
    //       await mockDiscountRepository.deleteDiscountsById(
    //         KTestVariables.discountModelItems.first.id,
    //       ),
    //       isA<Left<SomeFailure, bool>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });

    //   test('Deactivate discount failure', () async {
    //     expect(
    //       await mockDiscountRepository.deactivateDiscount(
    //         discountModel: KTestVariables.discountModelItems.first,
    //       ),
    //       isA<Left<SomeFailure, bool>>(),
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
