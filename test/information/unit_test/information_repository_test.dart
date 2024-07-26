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
  group('${KScreenBlocName.information} ${KGroupText.repository} ', () {
    late IInformationRepository mockInformationRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      ExtendedDateTime.current = KTestText.dateTime;
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successfulGet} ', () {
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
            KTestText.informationModelItems.first,
          ),
        ).thenAnswer(
          (_) async {},
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
      test('update', () async {
        expect(
          await mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.first,
            isLiked: true,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
    });
    group('${KGroupText.failureGet} ', () {
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
          FirebaseException(plugin: KGroupText.failure),
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
      test('update', () async {
        expect(
          await mockInformationRepository.updateLikeCount(
            informationModel: KTestText.informationModelItems.first,
            isLiked: true,
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
