import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

/// COMMENT: exmaple for stream repository
void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
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

        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }

        GetIt.I.registerSingleton(mockFirestoreService);
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
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(mockFirestoreService.getWorks()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }

        if (GetIt.I.isRegistered<StorageService>()) {
          GetIt.I.unregister<StorageService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        GetIt.I.registerSingleton(mockStorageService);
        mockWorkRepository = WorkRepository();
      });
      test('information', () async {
        expect(
          mockWorkRepository.getWorks(),
          emitsError(KGroupText.failureGet),
        );
      });
    });
  });
}
