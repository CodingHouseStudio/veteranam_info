import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/app/app.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  setUp(configureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenName.app} Page', () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpWidget(const App());

      expect(find.byKey(KWidgetkeys.appKeys.screen), findsOneWidget);
    });
  });
}
