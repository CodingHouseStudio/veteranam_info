import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.information} ${KGroupText.repository} ', () {
    late IInformationRepository mockInformationRepository;
    late FirestoreService mockFirestoreService;
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        ExtendedDateTime.id = '';
        ExtendedDateTime.customTime = KTestText.dateTime;
        mockFirestoreService = MockFirestoreService();
        mockInformationRepository = MockIInformationRepository();
        when(mockFirestoreService.getInformations()).thenAnswer(
          (_) => Stream.value(KTestText.informationModelItems),
        );
        when(
          mockFirestoreService.addInformation(
            KTestText.informationModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
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
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        ExtendedDateTime.id = '';
        mockFirestoreService = MockFirestoreService();
        //mockInformationRepository = MockIInformationRepository();
        when(mockFirestoreService.getInformations()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
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
    });
  });
}
