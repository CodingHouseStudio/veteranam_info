// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
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
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockFirestoreService.getDiscounts(
            showOnlyBusinessDiscounts: false, //null
          ),
        ).thenAnswer(
          (_) => Stream.value(KTestVariables.repositoryDiscountModelItems),
        );
        when(
          mockFirestoreService.addDiscount(
            KTestVariables.repositoryDiscountModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.getUserDiscountsLink(
            KTestVariables.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestVariables.linkModel],
        );
        when(
          mockFirestoreService.sendLink(
            KTestVariables.linkModel,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.getDiscount(
            id: KTestVariables.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (realInvocation) async => KTestVariables.discountModelItems.first,
        );

        when(
          mockFirestoreService.sendEmail(
            KTestVariables.emailModel,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });
      test('Discount get', () async {
        expect(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
          ),
          emits(KTestVariables.repositoryDiscountModelItems),
        );
      });
      test('add mock', () async {
        mockDiscountRepository.addMockDiscountItems();
        verify(
          mockFirestoreService.addDiscount(
            KTestVariables.repositoryDiscountModelItems.first,
          ),
        ).called(1);
      });
      test('User Can Send Link', () async {
        expect(
          await mockDiscountRepository.userCanSendLink(KTestVariables.user.id),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
      test('Send Link', () async {
        expect(
          await mockDiscountRepository.sendLink(KTestVariables.linkModel),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });

      test('User Can Send Email', () async {
        ExtendedDateTime.current = null;
        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestVariables.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestVariables.emailModel],
        );
        expect(
          await mockDiscountRepository
              .userCanSendUserEmail(KTestVariables.user.id),
          isA<Right<SomeFailure, int>>().having((e) => e.value, 'value', -1),
        );
      });
      test('User Can Send Email Wrong', () async {
        ExtendedDateTime.current = null;
        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestVariables.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestVariables.emailModelWrong],
        );
        expect(
          await mockDiscountRepository
              .userCanSendUserEmail(KTestVariables.user.id),
          isA<Right<SomeFailure, int>>().having((e) => e.value, 'value', 1),
        );
      });
      test('User Can Send Email Wrong, last sending was today', () async {
        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestVariables.user.id,
          ),
        ).thenAnswer(
          (realInvocation) async => [KTestVariables.emailModelWrong],
        );
        expect(
          await mockDiscountRepository
              .userCanSendUserEmail(KTestVariables.user.id),
          isA<Right<SomeFailure, int>>().having((e) => e.value, 'value', -1),
        );
      });
      test('Send Email', () async {
        expect(
          await mockDiscountRepository.sendEmail(KTestVariables.emailModel),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });

      test('Get Discount', () async {
        expect(
          await mockDiscountRepository.getDiscount(
            id: KTestVariables.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
          isA<Right<SomeFailure, DiscountModel>>().having(
            (e) => e.value,
            'value',
            KTestVariables.discountModelItems.first,
          ),
        );
      });

      test('Add Discount', () async {
        expect(
          await mockDiscountRepository
              .addDiscount(KTestVariables.repositoryDiscountModelItems.first),
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
          mockFirestoreService.getDiscounts(
            showOnlyBusinessDiscounts: false, //null
          ),
        ).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );

        when(
          mockFirestoreService.getUserDiscountsLink(
            KTestVariables.user.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendLink(
            KTestVariables.linkModel,
          ),
        ).thenThrow(
          Exception(KGroupText.failureSend),
        );

        when(
          mockFirestoreService.getUserDiscountsEmail(
            KTestVariables.user.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendEmail(
            KTestVariables.emailModel,
          ),
        ).thenThrow(
          Exception(KGroupText.failureSend),
        );
        when(
          mockFirestoreService.getDiscount(
            id: KTestVariables.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        // when(
        //   mockFirestoreService.getDiscountsByUserId(
        //     KTestVariables.user.id,
        //   ),
        // ).thenThrow(
        //   Exception(KGroupText.failureGet),
        // );
        when(
          mockFirestoreService.deleteDiscountById(
            KTestVariables.discountModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        when(
          mockFirestoreService.addDiscount(
            KTestVariables.repositoryDiscountModelItems.first,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );

        mockDiscountRepository =
            DiscountRepository(firestoreService: mockFirestoreService);
      });
      test('Discount get', () async {
        expect(
          mockDiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
          ),
          emitsError(KGroupText.failureGet),
        );
      });
      test('User Can Send Link', () async {
        expect(
          await mockDiscountRepository.userCanSendLink(KTestVariables.user.id),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Send Link', () async {
        expect(
          await mockDiscountRepository.sendLink(KTestVariables.linkModel),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('User Can Send Email', () async {
        expect(
          await mockDiscountRepository
              .userCanSendUserEmail(KTestVariables.user.id),
          isA<Left<SomeFailure, int>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Send Email', () async {
        expect(
          await mockDiscountRepository.sendEmail(KTestVariables.emailModel),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Get Discount', () async {
        expect(
          await mockDiscountRepository.getDiscount(
            id: KTestVariables.discountModelItems.first.id,
            showOnlyBusinessDiscounts: false,
          ),
          isA<Left<SomeFailure, DiscountModel>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      test('Delete discount', () async {
        expect(
          await mockDiscountRepository
              .deleteDiscountsById(KTestVariables.discountModelItems.first.id),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
      // test('Get discount use User Id', () async {
      //   expect(
      //     mockDiscountRepository.getDiscountsByUserId(KTestVariables.user
      // .id),
      //     isA<Left<SomeFailure, List<DiscountModel>>>(),
      //     // .having(
      //     //   (e) => e.value,
      //     //   'value',
      //     //   SomeFailure.serverError,
      //     // ),
      //   );
      // });
      // test('Get discount use User Id', () async {
      //   expect(
      //     mockDiscountRepository.getDiscountsByUserId(KTestVariables.user
      // .id),
      //     isA<Left<SomeFailure, List<DiscountModel>>>(),
      //     // .having(
      //     //   (e) => e.value,
      //     //   'value',
      //     //   SomeFailure.serverError,
      //     // ),
      //   );
      // });
      test('Add Discount', () async {
        expect(
          await mockDiscountRepository
              .addDiscount(KTestVariables.repositoryDiscountModelItems.first),
          isA<Left<SomeFailure, bool>>(),
        );
      });
    });
    // group('${KGroupText.firebaseFailure} ', () {
    //   setUp(() {
    //     when(
    //       mockFirestoreService.getUserDiscountsLink(
    //         KTestVariables.user.id,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failureGet),
    //     );
    //     when(
    //       mockFirestoreService.sendLink(
    //         KTestVariables.linkModel,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failureSend),
    //     );
    //     when(
    //       mockFirestoreService.getUserDiscountsEmail(
    //         KTestVariables.user.id,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failureGet),
    //     );
    //     when(
    //       mockFirestoreService.sendEmail(
    //         KTestVariables.emailModel,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failureSend),
    //     );
    //     when(
    //       mockFirestoreService.getDiscount(
    //         id: KTestVariables.discountModelItems.first.id,
    //         showOnlyBusinessDiscounts: false,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failureGet),
    //     );
    //     when(
    //       mockFirestoreService.addDiscount(
    //         KTestVariables.repositoryDiscountModelItems.first,
    //       ),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failureGet),
    //     );

    //     mockDiscountRepository =
    //         DiscountRepository(firestoreService: mockFirestoreService);
    //   });
    //   test('User Can Send Link', () async {
    //     expect(
    //       await mockDiscountRepository.userCanSendLink(KTestVariables.user.
    // id),
    //       isA<Left<SomeFailure, bool>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });
    //   test('Send Link', () async {
    //     expect(
    //       await mockDiscountRepository.sendLink(KTestVariables.linkModel),
    //       isA<Left<SomeFailure, bool>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });
    //   test('User Can Send Email', () async {
    //     expect(
    //       await mockDiscountRepository
    //           .userCanSendUserEmail(KTestVariables.user.id),
    //       isA<Left<SomeFailure, int>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });
    //   test('Send Email', () async {
    //     expect(
    //       await mockDiscountRepository.sendEmail(KTestVariables.emailModel),
    //       isA<Left<SomeFailure, bool>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });
    //   test('Get Discount', () async {
    //     expect(
    //       await mockDiscountRepository.getDiscount(
    //         id: KTestVariables.discountModelItems.first.id,
    //         showOnlyBusinessDiscounts: false,
    //       ),
    //       isA<Left<SomeFailure, DiscountModel>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });
    //   test('Add Discount', () async {
    //     expect(
    //       await mockDiscountRepository
    //           .addDiscount(KTestVariables.repositoryDiscountModelItems.
    // first),
    //       isA<Left<SomeFailure, bool>>(),
    //     );
    //   });
    // });
  });
}
