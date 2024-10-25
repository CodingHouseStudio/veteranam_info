import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

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
      Uint8ListExtension.imagePickerItem = KTestText.filePickerItemFeedback;
      if (GetIt.I.isRegistered<FirestoreService>()) {
        GetIt.I.unregister<FirestoreService>();
      }
      GetIt.I.registerSingleton(mockFirestoreService);

      if (GetIt.I.isRegistered<StorageService>()) {
        GetIt.I.unregister<StorageService>();
      }
      GetIt.I.registerSingleton(mockStorageService);
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockFirestoreService.addFeedback(KTestText.feedbackModel))
            .thenAnswer(
          (_) async {},
        );

        when(
          mockStorageService.saveFile(
            id: KTestText.feedbackImageModel.id,
            collecltionName: FirebaseCollectionName.mobFeedback,
            filePickerItem: KTestText.filePickerItemFeedback,
          ),
        ).thenAnswer(
          (_) async => KTestText.feedbackImageModel.image!.downloadURL,
        );

        when(mockFirestoreService.addMobFeedback(KTestText.feedbackImageModel))
            .thenAnswer(
          (_) async {},
        );
        when(
          mockFirestoreService.getUserFeedback(KTestText.user.id),
        ).thenAnswer(
          (_) async => [KTestText.feedbackModel],
        );
        mockFeedbackRepository = FeedbackRepository();
      });
      test('${KGroupText.successfulSet} feedback', () async {
        expect(
          await mockFeedbackRepository.sendFeedback(KTestText.feedbackModel),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('${KGroupText.successfulSet} mob feedback', () async {
        expect(
          await mockFeedbackRepository.sendMobFeedback(
            feedback: KTestText.feedbackImageModel,
            image: KTestText.filePickerItemFeedback.bytes,
          ),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
      test('${KGroupText.successfulGet} user feedback', () async {
        expect(
          await mockFeedbackRepository
              .checkUserNeedShowFeedback(KTestText.user.id),
          isA<Right<SomeFailure, bool>>()
              .having((e) => e.value, 'value', isTrue),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirestoreService.addFeedback(KTestText.feedbackModelIncorect),
        ).thenThrow(Exception(KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestText.fieldEmpty),
        ).thenThrow(Exception(KGroupText.failureGet));
        when(
          mockFirestoreService.addFeedback(
            KTestText.feedbackModelIncorect
                .copyWith(message: KTestText.fieldEmpty),
          ),
        ).thenThrow(Exception(KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestText.feedbackModel.id),
        ).thenThrow(Exception(KGroupText.failureGet));

        when(
          mockStorageService.saveFile(
            id: KTestText.feedbackImageModel.id,
            collecltionName: FirebaseCollectionName.mobFeedback,
            filePickerItem: KTestText.filePickerItemFeedback,
          ),
        ).thenThrow(Exception(KGroupText.failureSend));
        mockFeedbackRepository = FeedbackRepository();
      });
      test('${KGroupText.failureSend} feedback', () async {
        expect(
          await mockFeedbackRepository
              .sendFeedback(KTestText.feedbackModelIncorect),
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
            feedback: KTestText.feedbackImageModel,
            image: KTestText.filePickerItemFeedbackWrong.bytes,
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
              .checkUserNeedShowFeedback(KTestText.fieldEmpty),
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
            KTestText.feedbackModelIncorect
                .copyWith(message: KTestText.fieldEmpty),
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
            KTestText.feedbackModel.id,
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
          mockFirestoreService.addFeedback(KTestText.feedbackModelIncorect),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestText.fieldEmpty),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureGet));
        when(
          mockFirestoreService.addFeedback(
            KTestText.feedbackModelIncorect
                .copyWith(message: KTestText.fieldEmpty),
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        when(
          mockFirestoreService.getUserFeedback(KTestText.feedbackModel.id),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureGet));

        when(
          mockStorageService.saveFile(
            id: KTestText.feedbackModel.id,
            collecltionName: FirebaseCollectionName.mobFeedback,
            filePickerItem: KTestText.filePickerItemFeedback,
          ),
        ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
        mockFeedbackRepository = FeedbackRepository();
      });
      test('${KGroupText.failureSend} feedback', () async {
        expect(
          await mockFeedbackRepository
              .sendFeedback(KTestText.feedbackModelIncorect),
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
            feedback: KTestText.feedbackImageModel,
            image: KTestText.filePickerItemFeedbackWrong.bytes,
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
              .checkUserNeedShowFeedback(KTestText.fieldEmpty),
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
            KTestText.feedbackModelIncorect
                .copyWith(message: KTestText.fieldEmpty),
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
            KTestText.feedbackModel.id,
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
