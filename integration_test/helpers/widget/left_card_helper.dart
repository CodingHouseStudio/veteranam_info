import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> leftCardHelper(
  WidgetTester tester,
) async {
  if (find.byKey(KWidgetkeys.widget.leftCard.mob).evaluate().isNotEmpty) {
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
