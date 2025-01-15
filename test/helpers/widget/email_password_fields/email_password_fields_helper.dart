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
      findsOneWidget,
    );

    // expect(
    //   find.byKey(EmailPasswordFieldsKeys.textPassword),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(EmailPasswordFieldsKeys.buttonHidePassword),
      findsOneWidget,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconHidePassword),
      findsOneWidget,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEyeOff),
      findsOneWidget,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEye),
      findsNothing,
    );

    await tester.tap(find.byKey(EmailPasswordFieldsKeys.iconEyeOff));

    await tester.pumpAndSettle();

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEye),
      findsOneWidget,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEyeOff),
      findsNothing,
    );

    await tester.tap(find.byKey(EmailPasswordFieldsKeys.iconEye));

    await tester.pumpAndSettle();

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEyeOff),
      findsOneWidget,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEye),
      findsNothing,
    );
  } else {
    expect(
      find.byKey(EmailPasswordFieldsKeys.fieldEmail),
      findsOneWidget,
    );

    // expect(
    //   find.byKey(EmailPasswordFieldsKeys.textEmail),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(EmailPasswordFieldsKeys.fieldPassword),
      findsNothing,
    );

    // expect(
    //   find.byKey(EmailPasswordFieldsKeys.textPassword),
    //   findsNothing,
    // );

    expect(
      find.byKey(EmailPasswordFieldsKeys.buttonHidePassword),
      findsNothing,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEyeOff),
      findsNothing,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconEye),
      findsNothing,
    );

    expect(
      find.byKey(EmailPasswordFieldsKeys.iconHidePassword),
      findsNothing,
    );
  }
}
