import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.firestoreService} ${KGroupText.provider} ', () {
    late StorageService storageService;
    late FirebaseStorage mockFirebaseStorage;
    late Reference mockReference;
    late UploadTask mockUploadTask;
    late TaskSnapshot mockTaskSnapshot;
    setUp(() async {
      mockReference = MockReference();
      mockFirebaseStorage = MockFirebaseStorage();
      mockUploadTask = MockUploadTask();
      mockTaskSnapshot = MockTaskSnapshot();
      ExtendedDateTime.id = KTestVariables.id;
      when(
        mockFirebaseStorage.ref(
          StoragePath.getFilePath(
            collection: FirebaseCollectionName.stroies,
            modelId: KTestVariables.storyModelItems.last.id,
            fileExtension: KTestVariables.filePickerItem.extension,
            file: StoragePath.image,
            standartFileExtension: StoragePath.standartImageFileExtension,
          ),
        ),
      ).thenAnswer((realInvocation) => mockReference);
      when(
        mockReference.putData(KTestVariables.filePickerItem.bytes),
      ).thenAnswer(
        (realInvocation) {
          return mockUploadTask;
        },
      );
      when(
        mockUploadTask.catchError(StorageService.error),
      ).thenAnswer(
        (realInvocation) async => mockTaskSnapshot,
      );
      when(
        mockTaskSnapshot.ref,
      ).thenAnswer((realInvocation) => mockReference);
      when(
        mockReference.getDownloadURL(),
      ).thenAnswer(
        (realInvocation) async =>
            KTestVariables.storyModelItems.last.image!.downloadURL,
      );
      storageService = StorageService(storage: mockFirebaseStorage);
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
        filePickerItem: KTestVariables.filePickerItemEmpty,
        id: KTestVariables.storyModelItems.last.id,
        collecltionName: FirebaseCollectionName.stroies,
      );

      verifyNeverMethod(
        StoragePath.getFilePath(
          collection: FirebaseCollectionName.stroies,
          modelId: KTestVariables.storyModelItems.last.id,
          fileExtension: null, file: StoragePath.image,
          standartFileExtension: StoragePath.standartImageFileExtension,
          // imageName: KTestVariables.storyModelItems.last.image!.name,
        ),
      );
    });
    test('save story image', () async {
      await storageService.saveFile(
        filePickerItem: KTestVariables.filePickerItem,
        id: KTestVariables.storyModelItems.last.id,
        collecltionName: FirebaseCollectionName.stroies,
      );

      verifyMethod(
        StoragePath.getFilePath(
          collection: FirebaseCollectionName.stroies,
          modelId: KTestVariables.storyModelItems.last.id,
          fileExtension: null, file: StoragePath.image,
          standartFileExtension: StoragePath.standartImageFileExtension,
          // imageName: KTestVariables.storyModelItems.last.image!.name,
        ),
      );
    });
    // test('save resume', () async {
    //   await storageService.saveFile(
    //     respondId: KTestVariables.employeeRespondModel.id,

    //     resumeItem: KTestVariables.imagePickerItem,
    //     // collecltionName: FirebaseCollectionName.stroies,
    //   );

    //   // verifyMethod(
    //   StoragePath.getImagePath(
    //     collection: FirebaseCollectionName.stroies,
    //     modelId: KTestVariables.storyModelItems.last.id,
    //     imageExtension: null,
    //     // imageName: KTestVariables.storyModelItems.last.image!.name,
    //   );
    //   // );
    // });
  });
}
