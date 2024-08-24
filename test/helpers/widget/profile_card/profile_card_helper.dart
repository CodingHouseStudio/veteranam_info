import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> profileCardHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.profileCard.photo),
    findsOneWidget,
  );

  _noneEditPart(tester: tester, show: true);

  _editPart(tester: tester, show: false);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.profileCard.editButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.profileCard.editButton));

  await tester.pumpAndSettle();

  _editPart(tester: tester, show: true);

  _noneEditPart(tester: tester, show: false);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.profileCard.saveButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.profileCard.saveButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.anonymousSwitch),
    findsOneWidget,
  );

  await switchHelper(tester: tester);

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.connectAccountTitile),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.connectAccountIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.connectAccountText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.connectAccountTextField),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.connectAccountButton),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.connectAccountSubtitle),
    findsOneWidget,
  );
}

void _noneEditPart({required WidgetTester tester, required bool show}) {
  final matcher = show ? findsOneWidget : findsNothing;
  expect(
    find.byKey(KWidgetkeys.widget.profileCard.name),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.editButton),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.emailFied),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.nickNameText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.nickNameField),
    findsOneWidget,
  );
}

void _editPart({required WidgetTester tester, required bool show}) {
  final matcher = show ? findsOneWidget : findsNothing;

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.editText),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.nameText),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.nameField),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.lastNameText),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.lastNameField),
    matcher,
  );

  expect(
    find.byKey(KWidgetkeys.widget.profileCard.saveButton),
    matcher,
  );
}
