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

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.buttonHidePassword),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconHidePassword),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEyeOff),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEye),
      findsNothing,
    );

    await tester
        .tap(find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEyeOff));

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEye),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEyeOff),
      findsNothing,
    );

    await tester
        .tap(find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEye));

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEyeOff),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEye),
      findsNothing,
    );
  } else {
    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.buttonHidePassword),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEyeOff),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconEye),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.widget.emailPasswordFields.iconHidePassword),
      findsNothing,
    );
  }
}
