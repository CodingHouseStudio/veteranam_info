import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/text/text_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> employerInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(EmployerKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.subtitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: EmployerKeys.subtitle,
      );

      expect(
        find.byKey(EmployerKeys.mainInformation),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.textPosition),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.fieldPosition),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.textWage),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.fieldWage),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.textCity),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.fieldCity),
        findsOneWidget,
      );

      await dropListFieldHelper(
        tester: tester,
        text: KMockText.dropDownList.first,
        textFieldKey: EmployerKeys.fieldCity,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: EmployerKeys.fieldCity,
      );

      expect(
        find.byKey(EmployerKeys.switchWidget),
        findsOneWidget,
      );

      await switchHelper(tester: tester);

      expect(
        find.byKey(EmployerKeys.textSwitchWidget),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.textContact),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.fieldContact),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployerKeys.button),
        findsOneWidget,
      );
    },
  );
}
