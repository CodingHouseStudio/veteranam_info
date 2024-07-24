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
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockFirestoreService.getDiscounts()).thenAnswer(
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
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
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
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockFirestoreService.getDiscounts()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );

        when(
          mockFirestoreService.getUserDiscountsLink(
            KTestText.user.id,
          ),
        ).thenThrow(
          (realInvocation) async => Exception(KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendLink(
            KTestText.linkModel,
          ),
        ).thenThrow(
          (realInvocation) async => Exception(KGroupText.failureSend),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
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
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
      test('Send Link', () async {
        expect(
          await mockDiscountRepository.sendLink(KTestText.linkModel),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
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
          (realInvocation) async =>
              FirebaseException(plugin: KGroupText.failureGet),
        );
        when(
          mockFirestoreService.sendLink(
            KTestText.linkModel,
          ),
        ).thenThrow(
          (realInvocation) async =>
              FirebaseException(plugin: KGroupText.failureSend),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
      });
      test('User Can Send Link', () async {
        expect(
          await mockDiscountRepository.userCanSendLink(KTestText.user.id),
          isA<Left<SomeFailure, bool>>().having(
            (e) => e.value,
            'value',
            equals(const SomeFailure.serverError()),
          ),
        );
      });
      test('Send Link', () async {
        expect(
          await mockDiscountRepository.sendLink(KTestText.linkModel),
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
