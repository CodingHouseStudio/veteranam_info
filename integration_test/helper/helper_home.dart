import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/app/app.dart';
import 'package:kozak/shared/shared.dart';

Future<void> homeHelper(WidgetTester tester) async {
  await tester.pumpWidget(const App());

  expect(find.byKey(KWidgetkeys.appKeys.screen), findsOneWidget);
  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.homeKeys.screen), findsOneWidget);

  expect(find.byKey(KWidgetkeys.homeKeys.discountsButton), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.homeKeys.informationButton),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.homeKeys.investorsButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.homeKeys.profileButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.homeKeys.storyButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.homeKeys.workButton), findsOneWidget);
}
