// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

/// COMMENT: exmaple for stream repository
void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.workEmployee}  ${KGroupText.repository} ', () {
    late IWorkRepository mockWorkRepository;
    late FirestoreService mockFirestoreService;
    late StorageService mockStorageService;
    setUp(() {
      ExtendedDateTime.id = '';
      mockFirestoreService = MockFirestoreService();
      mockStorageService = MockStorageService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(mockFirestoreService.getWorks()).thenAnswer(
          (_) => Stream.value(KTestVariables.workModelItems),
        );
        when(
          mockFirestoreService.addWork(KTestVariables.workModelItems.first),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService
              .sendRespond(KTestVariables.employeeRespondModelModel),
        ).thenAnswer(
          (realInvocation) async {},
        );

        when(
          mockStorageService.saveFile(
            filePickerItem: KTestVariables.filePickerItem,
            collecltionName: FirebaseCollectionName.respond,
            id: KTestVariables.employeeRespondModelModel.id,
            file: StoragePath.resume,
            standartFileExtension: StoragePath.standartFileExtension,
          ),
        ).thenAnswer(
          (realInvocation) async => KTestVariables.downloadURL,
        );

        mockWorkRepository = WorkRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('Work', () async {
        expect(
          mockWorkRepository.getWorks(),
          emits(KTestVariables.workModelItems),
        );
      });
      test('mock', () async {
        mockWorkRepository.addMockWorks();
        verify(
          mockFirestoreService.addWork(KTestVariables.workModelItems.first),
        ).called(1);
      });
      test('send respond', () async {
        expect(
          await mockWorkRepository.sendRespond(
            respond: KTestVariables.employeeRespondModelModel,
            file: KTestVariables.filePickerItem,
          ),
          isA<Right<SomeFailure, bool>>().having((e) => e.value, 'value', true),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockFirestoreService.getWorks()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );
        when(
          mockFirestoreService
              .sendRespond(KTestVariables.employeeRespondModelModel),
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        mockWorkRepository = WorkRepository(
          firestoreService: mockFirestoreService,
          storageService: mockStorageService,
        );
      });
      test('information', () async {
        expect(
          mockWorkRepository.getWorks(),
          emitsError(KGroupText.failureGet),
        );
      });
      test('send respond', () async {
        expect(
          await mockWorkRepository.sendRespond(
            respond: KTestVariables.employeeRespondModelModel,
            file: KTestVariables.filePickerItem,
          ),
          isA<Left<SomeFailure, bool>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError,
          // ),
        );
      });
    });
    // group('${KGroupText.firebaseFailure} ', () {
    //   setUp(() {
    //     when(
    //       mockFirestoreService
    //           .sendRespond(KTestVariables.employeeRespondModelModel),
    //     ).thenThrow(
    //       FirebaseException(plugin: KGroupText.failure),
    //     );

    //     mockWorkRepository = WorkRepository(
    //       firestoreService: mockFirestoreService,
    //       storageService: mockStorageService,
    //     );
    //   });
    //   test('send respond', () async {
    //     expect(
    //       await mockWorkRepository.sendRespond(
    //         respond: KTestVariables.employeeRespondModelModel,
    //         file: KTestVariables.filePickerItem,
    //       ),
    //       isA<Left<SomeFailure, bool>>(),
    //       // .having(
    //       //   (e) => e.value,
    //       //   'value',
    //       //   SomeFailure.serverError,
    //       // ),
    //     );
    //   });
    // });
  });
}
