import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> leftCardHelper(
  WidgetTester tester,
) async {
  if (find.byKey(LeftCardKeys.mob).evaluate().isNotEmpty) {
    expect(
      find.byKey(LeftCardKeys.mob),
      findsOneWidget,
    );

    expect(find.byKey(LeftCardKeys.desk), findsNothing);
  } else {
    expect(find.byKey(LeftCardKeys.mob), findsNothing);

    // expect(find.byKey(LeftCardKeys.image), findsNothing);z

    expect(find.byKey(LeftCardKeys.desk), findsOneWidget);
  }
}
