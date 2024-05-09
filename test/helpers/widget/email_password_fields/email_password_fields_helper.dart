import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> emailPasswordFieldsHelper({
  required WidgetTester tester,
  required bool showPassword,
}) async {
  if (showPassword) {
    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
      findsWidgets,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
      findsWidgets,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.buttonHidePassword),
      findsWidgets,
    );
  } else {
    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
      findsWidgets,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
      findsNothing,
    );
  }
}
