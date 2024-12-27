import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.feedback} ${KGroupText.repository} ', () {
    late IFeedbackRepository mockFeedbackRepository;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    setUp(() {
      mockFirestoreService = MockFirestoreService();
      mockStorageService = MockStorageService();
      Uint8ListExtension.imagePickerItem =
          KTestVariables.filePickerItemFeedback;
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockFirestoreService.addFeedback(KTestVariables.feedbackModel))
            .thenAnswer(
          (_) async {},
        );

        when(
          mockStorageService.saveFile(
            id: KTestVariables.feedbackImageModel.id,
            collecltionName: FirebaseCollectionName.mobFeedback,
            filePickerItem: KTestVariables.filePickerItemFeedback,
          ),
        ).thenAnswer(
          (_) async => KTestVariables.feedbackImageModel.image!.downloadURL,
        );

        when(
          mockFirestoreService
              .addMobFeedback(KTestVariables.feedbackImageModel),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockFirestoreService.getUserFeedback(KTestVariables.user.id),
        ).thenAnswer(
          (_) async => [KTestVariables.feedbackModel],
        );

        mockFeedbackRepository = FeedbackRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('${KGroupText.successfulSet} feedback', () async {
        expect(
          await mockFeedbackRepository
              .sendFeedback(KTestVariables.feedbackModel),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('${KGroupText.successfulSet} mob feedback', () async {
        expect(
          await mockFeedbackRepository.sendMobFeedback(
            feedback: KTestVariables.feedbackImageModel,
            image: KTestVariables.filePickerItemFeedback.bytes,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('${KGroupText.successfulGet} user feedback', () async {
        expect(
          await mockFeedbackRepository
              .checkUserNeedShowFeedback(KTestVariables.user.id),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirestoreService
              .addFeedback(KTestVariables.feedbackModelIncorect),
        ).thenThrow(Exception(KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestVariables.fieldEmpty),
        ).thenThrow(Exception(KGroupText.failureGet));
        when(
          mockFirestoreService.addFeedback(
            KTestVariables.feedbackModelIncorect
                .copyWith(message: KTestVariables.fieldEmpty),
          ),
        ).thenThrow(Exception(KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestVariables.feedbackModel.id),
        ).thenThrow(Exception(KGroupText.failureGet));

        when(
          mockStorageService.saveFile(
            id: KTestVariables.feedbackImageModel.id,
            collecltionName: FirebaseCollectionName.mobFeedback,
            filePickerItem: KTestVariables.filePickerItemFeedback,
          ),
        ).thenThrow(Exception(KGroupText.failureSend));

        mockFeedbackRepository = FeedbackRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('${KGroupText.failureSend} feedback', () async {
        expect(
          await mockFeedbackRepository
              .sendFeedback(KTestVariables.feedbackModelIncorect),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureSend} mob feedback', () async {
        expect(
          await mockFeedbackRepository.sendMobFeedback(
            feedback: KTestVariables.feedbackImageModel,
            image: KTestVariables.filePickerItemFeedbackWrong.bytes,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureGet} user feedback', () async {
        expect(
          await mockFeedbackRepository
              .checkUserNeedShowFeedback(KTestVariables.fieldEmpty),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureSend} firebase feedback', () async {
        expect(
          await mockFeedbackRepository.sendFeedback(
            KTestVariables.feedbackModelIncorect
                .copyWith(message: KTestVariables.fieldEmpty),
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureGet} firebase user feedback', () async {
        expect(
          await mockFeedbackRepository.checkUserNeedShowFeedback(
            KTestVariables.feedbackModel.id,
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
          mockFirestoreService
              .addFeedback(KTestVariables.feedbackModelIncorect),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestVariables.fieldEmpty),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureGet));
        when(
          mockFirestoreService.addFeedback(
            KTestVariables.feedbackModelIncorect
                .copyWith(message: KTestVariables.fieldEmpty),
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestVariables.feedbackModel.id),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureGet));

        when(
          mockStorageService.saveFile(
            id: KTestVariables.feedbackModel.id,
            collecltionName: FirebaseCollectionName.mobFeedback,
            filePickerItem: KTestVariables.filePickerItemFeedback,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));

        mockFeedbackRepository = FeedbackRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('${KGroupText.failureSend} feedback', () async {
        expect(
          await mockFeedbackRepository
              .sendFeedback(KTestVariables.feedbackModelIncorect),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureSend} mob feedback', () async {
        expect(
          await mockFeedbackRepository.sendMobFeedback(
            feedback: KTestVariables.feedbackImageModel,
            image: KTestVariables.filePickerItemFeedbackWrong.bytes,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureGet} user feedback', () async {
        expect(
          await mockFeedbackRepository
              .checkUserNeedShowFeedback(KTestVariables.fieldEmpty),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureSend} firebase feedback', () async {
        expect(
          await mockFeedbackRepository.sendFeedback(
            KTestVariables.feedbackModelIncorect
                .copyWith(message: KTestVariables.fieldEmpty),
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('${KGroupText.failureGet} firebase user feedback', () async {
        expect(
          await mockFeedbackRepository.checkUserNeedShowFeedback(
            KTestVariables.feedbackModel.id,
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
