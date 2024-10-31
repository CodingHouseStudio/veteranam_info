import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

/// COMMENT: exmaple for stream repository
void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
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
          (_) => Stream.value(KTestText.workModelItems),
        );
        when(
          mockFirestoreService.addWork(KTestText.workModelItems.first),
        ).thenAnswer(
          (realInvocation) async {},
        );
        when(
          mockFirestoreService.sendRespond(KTestText.employeeRespondModelModel),
        ).thenAnswer(
          (realInvocation) async {},
        );

        when(
          mockStorageService.saveFile(
            filePickerItem: KTestText.filePickerItem,
            collecltionName: FirebaseCollectionName.respond,
            id: KTestText.employeeRespondModelModel.id,
            file: StoragePath.resume,
            standartFileExtension: StoragePath.standartFileExtension,
          ),
        ).thenAnswer(
          (realInvocation) async => KTestText.downloadURL,
        );

        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);

        mockWorkRepository = WorkRepository();
      });
      test('Work', () async {
        expect(
          mockWorkRepository.getWorks(),
          emits(KTestText.workModelItems),
        );
      });
      test('mock', () async {
        mockWorkRepository.addMockWorks();
        verify(
          mockFirestoreService.addWork(KTestText.workModelItems.first),
        ).called(1);
      });
      test('send respond', () async {
        expect(
          await mockWorkRepository.sendRespond(
            respond: KTestText.employeeRespondModelModel,
            file: KTestText.filePickerItem,
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
          mockFirestoreService.sendRespond(KTestText.employeeRespondModelModel),
        ).thenThrow(
          Exception(KGroupText.failure),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);
        mockWorkRepository = WorkRepository();
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
            respond: KTestText.employeeRespondModelModel,
            file: KTestText.filePickerItem,
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
          mockFirestoreService.sendRespond(KTestText.employeeRespondModelModel),
        ).thenThrow(
          FirebaseException(plugin: KGroupText.failure),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockStorageService);
        mockWorkRepository = WorkRepository();
      });
      test('send respond', () async {
        expect(
          await mockWorkRepository.sendRespond(
            respond: KTestText.employeeRespondModelModel,
            file: KTestText.filePickerItem,
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
