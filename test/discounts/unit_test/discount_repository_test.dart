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
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscounts(//null
              ),
        ).thenAnswer(
          (_) => Stream.value(KTestText.repositoryDiscountModelItems),
        );
        when(
          mockFirestoreService.addDiscount(
            KTestText.repositoryDiscountModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.getUserDiscountsLink(
            KTestText.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestText.linkModel],
        );
        when(
          mockFirestoreService.sendLink(
            KTestText.linkModel,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.getDiscount(
            id: KTestText.discountModelItems.first.id,
          ),
        ).thenAnswer(
          (realInvocation) async => KTestText.discountModelItems.first,
        );

        when(
          mockFirestoreService.sendEmail(
            KTestText.emailModel,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });
      test('Discount get', () async {
        expect(
          mockDiscountRepository.getDiscountItems(),
          emits(KTestText.repositoryDiscountModelItems),
        );
      });
      test('add mock', () async {
        mockDiscountRepository.addMockDiscountItems();
        verify(
          mockFirestoreService.addDiscount(
            KTestText.repositoryDiscountModelItems.first,
          ),
        ).called(1);
      });
      test('User Can Send Link', () async {
        expect(
          await mockDiscountRepository.userCanSendLink(KTestText.user.id),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
      test('Send Link', () async {
        expect(
          await mockDiscountRepository.sendLink(KTestText.linkModel),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });

      test('User Can Send Email', () async {
        ExtendedDateTime.current = null;
        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestText.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestText.emailModel],
        );
        expect(
          await mockDiscountRepository.userCanSendUserEmail(KTestText.user.id),
          isA<Right<SomeFailure, int>>().having((e) => e.value, 'value', -1),
        );
      });
      test('User Can Send Email Wrong', () async {
        ExtendedDateTime.current = null;
        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestText.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestText.emailModelWrong],
        );
        expect(
          await mockDiscountRepository.userCanSendUserEmail(KTestText.user.id),
          isA<Right<SomeFailure, int>>().having((e) => e.value, 'value', 1),
        );
      });
      test('User Can Send Email Wrong, last sending was today', () async {
        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestText.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestText.emailModelWrong],
        );
        expect(
          await mockDiscountRepository.userCanSendUserEmail(KTestText.user.id),
          isA<Right<SomeFailure, int>>().having((e) => e.value, 'value', -1),
        );
      });
      test('Send Email', () async {
        expect(
          await mockDiscountRepository.sendEmail(KTestText.emailModel),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });

      test('Get Discount', () async {
        expect(
          await mockDiscountRepository
              .getDiscount(KTestText.discountModelItems.first.id),
          isA<Right<SomeFailure, DiscountModel>>().having(
            (e) => e.value,
            'value',
            KTestText.discountModelItems.first,
          ),
        );
      });

      test('Add Discount', () async {
        expect(
          await mockDiscountRepository
              .addDiscount(KTestText.repositoryDiscountModelItems.first),
          isA<Right<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            true,
          ),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscounts(//null
              ),
        ).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );

        when(
          mockFirestoreService.getUserDiscountsLink(
            KTestText.user.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendLink(
            KTestText.linkModel,
          ),
        ).thenThrow(
          Exception(KGroupText.failureSend),
        );

        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestText.user.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendEmail(
            KTestText.emailModel,
          ),
        ).thenThrow(
          Exception(KGroupText.failureSend),
        );
        when(
          mockFirestoreService.getDiscount(
            id: KTestText.discountModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        // when(
        //   mockFirestoreService.getDiscountsByUserId(
        //     KTestText.user.id,
        //   ),
        // ).thenThrow(
        //   Exception(KGroupText.failureGet),
        // );
        when(
          mockFirestoreService.deleteDiscountById(
            KTestText.discountModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        when(
          mockFirestoreService.addDiscount(
            KTestText.repositoryDiscountModelItems.first,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });
      test('Discount get', () async {
        expect(
          mockDiscountRepository.getDiscountItems(),
          emitsError(KGroupText.failureGet),
        );
      });
      test('User Can Send Link', () async {
        expect(
          await mockDiscountRepository.userCanSendLink(KTestText.user.id),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Send Link', () async {
        expect(
          await mockDiscountRepository.sendLink(KTestText.linkModel),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('User Can Send Email', () async {
        expect(
          await mockDiscountRepository.userCanSendUserEmail(KTestText.user.id),
          isA<Left<SomeFailure, int>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Send Email', () async {
        expect(
          await mockDiscountRepository.sendEmail(KTestText.emailModel),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Get Discount', () async {
        expect(
          await mockDiscountRepository
              .getDiscount(KTestText.discountModelItems.first.id),
          isA<Left<SomeFailure, DiscountModel>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Delete discount', () async {
        expect(
          await mockDiscountRepository
              .deleteDiscountsById(KTestText.discountModelItems.first.id),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      // test('Get discount use User Id', () async {
      //   expect(
      //     mockDiscountRepository.getDiscountsByUserId(KTestText.user.id),
      //     isA<Left<SomeFailure, List<DiscountModel>>>(),
      //     // .having(
      //     //   (e) => e.value,
      //     //   'value',
      //     //   SomeFailure.serverError(error: null),
      //     // ),
      //   );
      // });
      // test('Get discount use User Id', () async {
      //   expect(
      //     mockDiscountRepository.getDiscountsByUserId(KTestText.user.id),
      //     isA<Left<SomeFailure, List<DiscountModel>>>(),
      //     // .having(
      //     //   (e) => e.value,
      //     //   'value',
      //     //   SomeFailure.serverError(error: null),
      //     // ),
      //   );
      // });
      test('Add Discount', () async {
        expect(
          await mockDiscountRepository
              .addDiscount(KTestText.repositoryDiscountModelItems.first),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
    group('${KGroupText.firebaseFailure} ', () {
      setUp(() {
        when(
          mockFirestoreService.getUserDiscountsLink(
            KTestText.user.id,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendLink(
            KTestText.linkModel,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureSend),
        );
        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestText.user.id,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendEmail(
            KTestText.emailModel,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureSend),
        );
        when(
          mockFirestoreService.getDiscount(
            id: KTestText.discountModelItems.first.id,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureGet),
        );
        when(
          mockFirestoreService.addDiscount(
            KTestText.repositoryDiscountModelItems.first,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureGet),
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });
      test('User Can Send Link', () async {
        expect(
          await mockDiscountRepository.userCanSendLink(KTestText.user.id),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Send Link', () async {
        expect(
          await mockDiscountRepository.sendLink(KTestText.linkModel),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('User Can Send Email', () async {
        expect(
          await mockDiscountRepository.userCanSendUserEmail(KTestText.user.id),
          isA<Left<SomeFailure, int>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Send Email', () async {
        expect(
          await mockDiscountRepository.sendEmail(KTestText.emailModel),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Get Discount', () async {
        expect(
          await mockDiscountRepository
              .getDiscount(KTestText.discountModelItems.first.id),
          isA<Left<SomeFailure, DiscountModel>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Add Discount', () async {
        expect(
          await mockDiscountRepository
              .addDiscount(KTestText.repositoryDiscountModelItems.first),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
  });
}
