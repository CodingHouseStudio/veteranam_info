import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../test_dependency.dart';

// import 'helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
//   group('${KScreenBlocName.contact} ', () {
//     testWidgets('${KGroupText.intial} ', (tester) async {
//       await contactPumpAppHelper(tester: tester);
//     });
//     group('${KGroupText.goRouter} ', () {
//       late MockGoRouter mockGoRouter;
//       setUp(() => mockGoRouter = MockGoRouter());
//       testWidgets('${KGroupText.intial} ', (tester) async {
//         await contactPumpAppHelper(tester: tester, mockGoRouter:
// mockGoRouter);
//       });
//       // group('${KGroupText.goTo} ', () {
//       // });
//     });
//   });
}
