import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import '../text_dependency.dart';
import 'helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.myStory} ', () {
    testWidgets('${KGroupText.intial} ', (tester) async {
      await myStoryPumpAppHelper(tester: tester);

      await employerInitialHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        await myStoryPumpAppHelper(tester: tester, mockGoRouter: mockGoRouter);

        await employerInitialHelper(tester);
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
