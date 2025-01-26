import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.information} ', () {
    setUp(informatonWidgetTestRegister);

    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockInformationRepository.getInformationItems(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (invocation) => Stream.error(Exception(KGroupText.failureGet)),
        );
      });
      testWidgets('${KGroupText.failureGet} ', (tester) async {
        await informationPumpAppHelper(
          tester,
        );

        await loadingFailureHelper(
          tester: tester,
          card: InformationKeys.card,
          buttonMock: InformationKeys.buttonMock,
        );
      });
    });
    group('${KGroupText.getEmptyList} ', () {
      setUp(() {
        when(
          mockInformationRepository.getInformationItems(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer(
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
          tester,
        );

        await mockButtonHelper(
          tester: tester,
          card: InformationKeys.card,
          buttonMock: InformationKeys.buttonMock,
        );
      });
    });
    group('${KGroupText.getList} ', () {
      setUp(() {
        when(
          mockInformationRepository.getInformationItems(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (invocation) => Stream.value(KTestVariables.informationModelItems),
        );
      });

      testWidgets('${KGroupText.initial} ', (tester) async {
        await informationPumpAppHelper(
          tester,
        );

        await informationInitialHelper(tester);
      });

      loadingList(
        (tester) async => informationPumpAppHelper(
          tester,
        ),
        // lastCard: InformationKeys.cardLast,
      );

      testWidgets('News list load and filter', (tester) async {
        await informationPumpAppHelper(
          tester,
        );

        await listLoadFilterHelper(tester);
      });

      group('${KGroupText.goRouter} ', () {
        late MockGoRouter mockGoRouter;
        setUp(() => mockGoRouter = MockGoRouter());
        testWidgets('${KGroupText.initial} ', (tester) async {
          await informationPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await informationInitialHelper(tester);
        });
      });
    });
  });
}
