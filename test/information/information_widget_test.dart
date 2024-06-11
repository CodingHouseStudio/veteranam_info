import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.information} ', () {
    late IInformationRepository mockInformationRepository;
    setUp(() {
      mockInformationRepository = MockIInformationRepository();
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          tester: tester,
        );

        await informationFailureHelper(tester);
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (invocation) => Stream.value([]),
        );

        when(mockInformationRepository.addMockInformationItems()).thenAnswer(
          (invocation) {},
        );
        if (GetIt.I.isRegistered<IInformationRepository>()) {
          GetIt.I.unregister<IInformationRepository>();
        }
        GetIt.I.registerSingleton<IInformationRepository>(
          mockInformationRepository,
        );
      });
      testWidgets('${KGroupText.mockButton} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          tester: tester,
        );

        await informationMockButtonHelper(tester);
      });
    });
    group(KGroupText.getList, () {
      setUp(() {
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (invocation) => Stream.value(KTestText.informationModelItems),
        );
      });

      testWidgets('${KGroupText.intial} ', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          tester: tester,
        );

        await informationInitialHelper(tester);
      });

      testWidgets('News list load and filter', (tester) async {
        await informationPumpAppHelper(
          mockInformationRepository: mockInformationRepository,
          tester: tester,
        );

        await listLoadFilterHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.intial} ', (tester) async {
          await informationPumpAppHelper(
            mockInformationRepository: mockInformationRepository,
            tester: tester,
            mockGoRouter: mockGoRouter,
          );

          await informationInitialHelper(tester);
        });

        // group('${KGroupText.goTo} ', () {
        // });
      });
    });
  });
}
