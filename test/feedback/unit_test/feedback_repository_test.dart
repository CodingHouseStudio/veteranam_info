import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.feedback} ${KGroupText.repository} ', () {
    late IFeedbackRepository mockFeedbackRepository;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    late Uint8List image;
    late Uint8List wrongImage;
    setUp(() {
      mockFirestoreService = MockFirestoreService();
      mockStorageService = MockStorageService();
      image = Uint8List(1);
      wrongImage = Uint8List(2);
      when(mockFirestoreService.addFeedback(KTestText.feedbackModel))
          .thenAnswer(
        (_) async {},
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
        mockStorageService.saveUseUint8ListImage(
          id: KTestText.feedbackModel.id,
          collecltionName: FirebaseCollectionName.mobFeedback,
          image: image,
        ),
      ).thenAnswer(
        (_) async => KTestText.feedbackImageModel.image!.downloadURL,
      );
      when(
        mockStorageService.saveUseUint8ListImage(
          id: KTestText.feedbackModel.id,
          collecltionName: FirebaseCollectionName.mobFeedback,
          image: wrongImage,
        ),
      ).thenThrow(FirebaseException(plugin: KGroupText.failureSend));
      if (GetIt.I.isRegistered<FirestoreService>()) {
        GetIt.I.unregister<FirestoreService>();
      }
      GetIt.I.registerSingleton(mockFirestoreService);

      if (GetIt.I.isRegistered<StorageService>()) {
        GetIt.I.unregister<StorageService>();
      }
      GetIt.I.registerSingleton(mockStorageService);
      mockFeedbackRepository = FeedbackRepository();
    });
    test('${KGroupText.successfulSet} feedback', () async {
      expect(
        await mockFeedbackRepository.sendFeedback(KTestText.feedbackModel),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('${KGroupText.successfulSet} mob feedback', () async {
      expect(
        await mockFeedbackRepository.sendMobFeedback(
          feedback: KTestText.feedbackImageModel,
          image: image,
        ),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('${KGroupText.successfulGet} user feedback', () async {
      expect(
        await mockFeedbackRepository
            .checkUserNeedShowFeedback(KTestText.user.id),
        isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', isTrue),
      );
    });
    test('${KGroupText.failureSend} feedback', () async {
      expect(
        await mockFeedbackRepository
            .sendFeedback(KTestText.feedbackModelIncorect),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('${KGroupText.failureSend} mob feedback', () async {
      expect(
        await mockFeedbackRepository.sendMobFeedback(
          feedback: KTestText.feedbackImageModel,
          image: wrongImage,
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('${KGroupText.failureGet} user feedback', () async {
      expect(
        await mockFeedbackRepository
            .checkUserNeedShowFeedback(KTestText.fieldEmpty),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('${KGroupText.failureSend} firebase feedback', () async {
      expect(
        await mockFeedbackRepository.sendFeedback(
          KTestText.feedbackModelIncorect
              .copyWith(message: KTestText.fieldEmpty),
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
    test('${KGroupText.failureGet} firebase user feedback', () async {
      expect(
        await mockFeedbackRepository.checkUserNeedShowFeedback(
          KTestText.feedbackModel.id,
        ),
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          const SomeFailure.serverError(),
        ),
      );
    });
  });
}
