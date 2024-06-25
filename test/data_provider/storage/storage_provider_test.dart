import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.firestoreService} ${KGroupText.provider} ', () {
    late StorageService storageService;
    late FirebaseStorage mockFirebaseStorage;
    late Reference mockReference;
    late UploadTask mockUploadTask;
    late TaskSnapshot mockTaskSnapshot;
    late Uint8List uint8List;
    setUp(() async {
      mockReference = MockReference();
      mockFirebaseStorage = MockFirebaseStorage();
      mockUploadTask = MockUploadTask();
      mockTaskSnapshot = MockTaskSnapshot();
      uint8List = Uint8List(1);
      StorageService.firebaseStorage = mockFirebaseStorage;
      StorageService.uint8List = Future.value(uint8List);
      when(
        mockFirebaseStorage.ref(
          StoragePath.getImagePath(
            collenction: FirebaseCollectionName.stroies,
            modelId: KTestText.storyModelItems.last.id,
            imageName: KTestText.storyModelItems.last.image!.name,
          ),
        ),
      ).thenAnswer((realInvocation) => mockReference);
      when(
        mockReference.putBlob(uint8List),
      ).thenAnswer(
        (realInvocation) {
          UploadTaskExtention.taskSnapshot = Future.value(mockTaskSnapshot);
          return mockUploadTask;
        },
      );
      // when(
      //   mockUploadTask.getTaskSnapshot(),
      // ).thenAnswer(
      //   (realInvocation) async => mockTaskSnapshot,
      // );
      when(
        mockTaskSnapshot.ref,
      ).thenAnswer((realInvocation) => mockReference);
      when(
        mockReference.getDownloadURL(),
      ).thenAnswer(
        (realInvocation) async =>
            KTestText.storyModelItems.last.image!.downloadURL,
      );
      storageService = StorageService();
    });
    void verifyMethod(String path) {
      verify(
        mockFirebaseStorage.ref(path),
      ).called(1);
      verify(
        mockReference.putBlob(uint8List),
      ).called(1);
      verify(
        mockTaskSnapshot.ref,
      ).called(1);
      verify(
        mockReference.getDownloadURL(),
      ).called(1);
    }

    void verifyNeverMethod(String path) {
      verifyNever(
        mockFirebaseStorage.ref(path),
      );
      verifyNever(
        mockReference.putBlob(uint8List),
      );
      verifyNever(
        mockTaskSnapshot.ref,
      );
      verifyNever(
        mockReference.getDownloadURL(),
      );
    }

    test('save empty story image', () async {
      await storageService.saveStoryImage(
        imageModel: KTestText.storyModelItems.last.image!.copyWith(
          ref: null,
        ),
        storyId: KTestText.storyModelItems.last.id,
      );

      verifyNeverMethod(
        StoragePath.getImagePath(
          collenction: FirebaseCollectionName.stroies,
          modelId: KTestText.storyModelItems.last.id,
          imageName: KTestText.storyModelItems.last.image!.name,
        ),
      );
    });
    test('save story image', () async {
      await storageService.saveStoryImage(
        imageModel: KTestText.storyModelItems.last.image!,
        storyId: KTestText.storyModelItems.last.id,
      );

      verifyMethod(
        StoragePath.getImagePath(
          collenction: FirebaseCollectionName.stroies,
          modelId: KTestText.storyModelItems.last.id,
          imageName: KTestText.storyModelItems.last.image!.name,
        ),
      );
    });
  });
}
