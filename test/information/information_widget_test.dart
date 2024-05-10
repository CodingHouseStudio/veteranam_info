import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
// ignore: unused_import
import 'package:kozak/components/components.dart';
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
}
