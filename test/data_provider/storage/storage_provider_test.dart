import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.firestoreService} ${KGroupText.provider} ', () {
    late StorageService storageService;
    late FirebaseStorage mockFirebaseStorage;
    late Reference mockReference;
    late UploadTask mockUploadTask;
    late TaskSnapshot mockTaskSnapshot;
    // late Uint8List uint8List;
    setUp(() async {
      mockReference = MockReference();
      mockFirebaseStorage = MockFirebaseStorage();
      mockUploadTask = MockUploadTask();
      mockTaskSnapshot = MockTaskSnapshot();
      // uint8List = Uint8List(1);
      ExtendedDateTime.id = KTestText.id;
      StorageService.firebaseStorage = mockFirebaseStorage;
      // StorageService.uint8List = Future.value(uint8List);
      when(
        mockFirebaseStorage.ref(
          StoragePath.getImagePath(
            collection: FirebaseCollectionName.stroies,
            modelId: KTestText.storyModelItems.last.id,
            imageExtension: null,
            // imageName: KTestText.storyModelItems.last.image!.name,
          ),
        ),
      ).thenAnswer((realInvocation) => mockReference);
      when(
        mockFirebaseStorage.ref(
          StoragePath.getResumePath(
            collection: FirebaseCollectionName.respond,
            modelId: KTestText.employeeRespondModel.id,
            // resumeName: KTestText.employeeRespondModel.resume!.name,
            fileExtension: null,
          ),
        ),
      ).thenAnswer((realInvocation) => mockReference);
      // when(
      //   mockReference.putBlob(uint8List),
      // ).thenAnswer(
      //   (realInvocation) {
      //     // UploadTaskExtention.taskSnapshot = Future.value(mockTaskSnapshot);
      //     return mockUploadTask;
      //   },
      // );
      when(
        mockReference.putData(KTestText.imagePickerItem.bytes),
      ).thenAnswer(
        (realInvocation) {
          // UploadTaskExtention.taskSnapshot = Future.value(mockTaskSnapshot);
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
      // verify(
      //   mockReference.putBlob(uint8List),
      // ).called(1);
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
      // verifyNever(
      //   mockReference.putBlob(uint8List),
      // );
      verifyNever(
        mockTaskSnapshot.ref,
      );
      verifyNever(
        mockReference.getDownloadURL(),
      );
    }

    test('save empty story image', () async {
      await storageService.saveFile(
        imagePickerItem: KTestText.imagePickerItem,
        id: KTestText.storyModelItems.last.id,
        collecltionName: FirebaseCollectionName.stroies,
      );

      verifyNeverMethod(
        StoragePath.getImagePath(
          collection: FirebaseCollectionName.stroies,
          modelId: KTestText.storyModelItems.last.id,
          imageExtension: null,
          // imageName: KTestText.storyModelItems.last.image!.name,
        ),
      );
    });
    test('save story image', () async {
      await storageService.saveFile(
        imagePickerItem: KTestText.imagePickerItem,
        id: KTestText.storyModelItems.last.id,
        collecltionName: FirebaseCollectionName.stroies,
      );

      verifyMethod(
        StoragePath.getImagePath(
          collection: FirebaseCollectionName.stroies,
          modelId: KTestText.storyModelItems.last.id,
          imageExtension: null,
          // imageName: KTestText.storyModelItems.last.image!.name,
        ),
      );
    });
    // test('save resume', () async {
    //   await storageService.saveFile(
    //     respondId: KTestText.employeeRespondModel.id,

    //     resumeItem: KTestText.imagePickerItem,
    //     // collecltionName: FirebaseCollectionName.stroies,
    //   );

    //   // verifyMethod(
    //   StoragePath.getImagePath(
    //     collection: FirebaseCollectionName.stroies,
    //     modelId: KTestText.storyModelItems.last.id,
    //     imageExtension: null,
    //     // imageName: KTestText.storyModelItems.last.image!.name,
    //   );
    //   // );
    // });
  });
}
