import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> emailPasswordFieldsHelper({
  required WidgetTester tester,
  required bool showPassword,
}) async {
  if (showPassword) {
    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
      findsNothing,
    );

    // expect(
    //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
    //   findsNothing,
    // );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
      findsWidgets,
    );

    // expect(
    //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
    //   findsWidgets,
    // );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.buttonHidePassword),
      findsWidgets,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEyeOff),
      findsWidgets,
    );
  } else {
    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
      findsWidgets,
    );

    // expect(
    //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
    //   findsWidgets,
    // );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
      findsNothing,
    );

    // expect(
    //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
    //   findsNothing,
    //);

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.buttonHidePassword),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEyeOff),
      findsNothing,
    );
  }
}
