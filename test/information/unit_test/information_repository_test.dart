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

  group('${KScreenBlocName.information} ${KGroupText.repository} ', () {
    late IInformationRepository mockInformationRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      ExtendedDateTime.current = KTestText.dateTime;
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockFirestoreService.getInformations(null)).thenAnswer(
          (_) => Stream.value(KTestText.informationModelItems),
        );
        when(
          mockFirestoreService.addInformation(
            KTestText.informationModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.updateInformationModel(
            KTestText.informationModelItems.first.copyWith(likes: 2),
          ),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockFirestoreService.updateInformationModel(
            KTestText.informationModelItems.first.copyWith(likes: null),
          ),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockFirestoreService.getInformation(
            KTestText.informationModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => KTestText.informationModelItems.first,
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockInformationRepository = InformationRepository();
      });
      test('information', () async {
        expect(
          mockInformationRepository.getInformationItems(),
          emits(KTestText.informationModelItems),
        );
      });
      test('mock', () async {
        mockInformationRepository.addMockInformationItems();
        verify(
          mockFirestoreService.addInformation(
            KTestText.informationModelItems.first,
          ),
        ).called(1);
      });
      test('update like count(plus)', () async {
        expect(
          await mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.first,
            isLiked: true,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
      test('update like count(minus, result null)', () async {
        expect(
          await mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.first,
            isLiked: false,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
      test('update like count(minus)', () async {
        expect(
          await mockInformationRepository.updateLikeCount(
            informationModel:
                KTestText.informationModelItems.first.copyWith(likes: 2),
            isLiked: false,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
      test('get information', () async {
        expect(
          await mockInformationRepository.getInformation(
            KTestText.informationModelItems.first.id,
          ),
          isA<Right<SomeFailure, InformationModel>>().having(
            (e) => e.value,
            'value',
            KTestText.informationModelItems.first,
          ),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockFirestoreService.getInformations(null)).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );
        when(
          mockFirestoreService.updateInformationModel(
            KTestText.informationModelItems.first.copyWith(
              likes: KTestText.informationModelItems.first.likes ?? 0 + 1,
            ),
          ),
        ).thenThrow(
          Exception(KGroupText.failureSend),
        );
        when(
          mockFirestoreService.getInformation(
            KTestText.informationModelItems.first.id,
          ),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockInformationRepository = InformationRepository();
      });
      test('information', () async {
        expect(
          mockInformationRepository.getInformationItems(),
          emitsError(KGroupText.failureGet),
        );
      });
      test('update like count', () async {
        expect(
          await mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.first,
            isLiked: true,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('get information', () async {
        expect(
          await mockInformationRepository.getInformation(
            KTestText.informationModelItems.first.id,
          ),
          isA<Left<SomeFailure, InformationModel>>(),
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
          mockFirestoreService.updateInformationModel(
            KTestText.informationModelItems.first.copyWith(
              likes: KTestText.informationModelItems.first.likes ?? 0 + 1,
            ),
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureSend),
        );
        when(
          mockFirestoreService.getInformation(
            KTestText.informationModelItems.first.id,
          ),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failureGet),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockInformationRepository = InformationRepository();
      });
      test('update like count', () async {
        expect(
          await mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.first,
            isLiked: true,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('get infromation', () async {
        expect(
          await mockInformationRepository.getInformation(
            KTestText.informationModelItems.first.id,
          ),
          isA<Left<SomeFailure, InformationModel>>(),
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
