import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/app/app.dart';
import 'package:kozak/shared/shared.dart';

Future<void> homeHelper(WidgetTester tester) async {
  await tester.pumpWidget(const App());

  expect(find.byKey(KWIdgetkeys.appKeys.screen), findsOneWidget);
  await tester.pumpAndSettle();

  expect(find.byKey(KWIdgetkeys.homeKeys.screen), findsOneWidget);

  expect(find.byKey(KWIdgetkeys.homeKeys.discountsButton), findsOneWidget);

  expect(
    find.byKey(KWIdgetkeys.homeKeys.informationButton),
    findsOneWidget,
  );

  expect(find.byKey(KWIdgetkeys.homeKeys.investorsButton), findsOneWidget);

  expect(find.byKey(KWIdgetkeys.homeKeys.profileButton), findsOneWidget);

  expect(find.byKey(KWIdgetkeys.homeKeys.storyButton), findsOneWidget);

  expect(find.byKey(KWIdgetkeys.homeKeys.workButton), findsOneWidget);
}
