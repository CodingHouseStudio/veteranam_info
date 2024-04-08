import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/app.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group(KScreenBlocName.app, () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpWidget(const App());

      expect(
        find.byKey(KWidgetkeys.screen.app.screen),
        findsOneWidget,
      );

      await nawbarHelper(tester: tester, searchText: KTestText.field);

      await footerHelper(tester: tester, email: KTestText.useremail);
    });
  });
}
