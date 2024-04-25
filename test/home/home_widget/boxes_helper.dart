import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> boxexHelper({
  required WidgetTester tester,
  required List<String> routes,
  required MockGoRouter mockGoRouter,
}) async {
  final boxWidgetsIcon =
      tester.widgetList(find.byKey(KWidgetkeys.widget.box.icon));
  for (var i = 0; i < boxWidgetsIcon.length; i++) {
    await scrollingHelper(
      tester: tester,
      itemFinder: find.byWidget(boxWidgetsIcon.elementAt(i)),
    );

    await tester.tap(find.byWidget(boxWidgetsIcon.elementAt(i)));

    verify(
      () => mockGoRouter.goNamed(
        routes.elementAt(i),
      ),
    ).called(1);
  }
}
