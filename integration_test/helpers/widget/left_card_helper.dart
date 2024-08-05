import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> leftCardHelper(
  WidgetTester tester,
) async {
  final mob = tester.widgetList(find.byKey(KWidgetkeys.widget.leftCard.mob));
  if (mob.isNotEmpty) {
    expect(
      find.byKey(KWidgetkeys.widget.leftCard.mob),
      findsOneWidget,
    );

    expect(find.byKey(KWidgetkeys.widget.leftCard.desk), findsNothing);
  } else {
    expect(find.byKey(KWidgetkeys.widget.leftCard.mob), findsNothing);

    // expect(find.byKey(KWidgetkeys.widget.leftCard.image), findsNothing);z

    expect(find.byKey(KWidgetkeys.widget.leftCard.desk), findsOneWidget);
  }
}
