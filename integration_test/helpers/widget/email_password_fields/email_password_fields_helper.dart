import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> emailPasswordFieldsHelper({
  required WidgetTester tester,
  required bool showPassword,
}) async {
  if (showPassword) {
    expect(
      find.byKey(EmailPasswordFieldsKeys.fieldEmail),
      findsNothing,
    );

    // expect(
    //   find.byKey(EmailPasswordFieldsKeys.textEmail),
    //   findsNothing,
    // );

    expect(
      find.byKey(EmailPasswordFieldsKeys.fieldPassword),
      findsWidgets,
    );

    // expect(
    //   find.byKey(EmailPasswordFieldsKeys.textPassword),
    //   findsWidgets,
    // );

    expect(
      find.byKey(EmailPasswordFieldsKeys.buttonHidePassword),
      findsWidgets,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEyeOff),
      findsWidgets,
    );
  } else {
    expect(
      find.byKey(EmailPasswordFieldsKeys.fieldEmail),
      findsWidgets,
    );

    // expect(
    //   find.byKey(EmailPasswordFieldsKeys.textEmail),
    //   findsWidgets,
    // );

    expect(
      find.byKey(EmailPasswordFieldsKeys.fieldPassword),
      findsNothing,
    );

    // expect(
    //   find.byKey(EmailPasswordFieldsKeys.textPassword),
    //   findsNothing,
    //);

    expect(
      find.byKey(EmailPasswordFieldsKeys.buttonHidePassword),
      findsNothing,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEyeOff),
      findsNothing,
    );
  }
}
