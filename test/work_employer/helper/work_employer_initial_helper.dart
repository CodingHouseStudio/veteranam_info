import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> employerInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.employer.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.subtitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.employer.subtitle,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.mainInformation),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textPosition),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldPosition),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textWage),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldWage),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textCity),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldCity),
        findsOneWidget,
      );

      await dropListFieldHelper(
        tester: tester,
        text: KMockText.dropDownList.first,
        textFieldKey: KWidgetkeys.screen.employer.fieldCity,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.employer.fieldCity,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.switchWidget),
        findsOneWidget,
      );

      await switchHelper(tester: tester);

      expect(
        find.byKey(KWidgetkeys.screen.employer.textSwitchWidget),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.textContact),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.fieldContact),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employer.button),
        findsOneWidget,
      );
    },
  );
}
