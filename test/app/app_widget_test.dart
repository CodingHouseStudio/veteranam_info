import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/app/app.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  group(KScreenName.app, () {
    setUp(configureDependenciesTest);

    setUpAll(setUpGlobal);

    setupFirebaseAuthMocks();

    tearDown(GetIt.I.reset);
    testWidgets('renders initial', (tester) async {
      await tester.pumpWidget(const App());

      expect(find.byKey(KWidgetkeys.appScreenKeys.screen), findsOneWidget);

      await nawbarHelper(tester: tester, searchText: '');
    });
  });
}
