import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/constants/constants.dart';

import '../../text_dependency.dart';
import 'helper.dart';

Future<void> homeInitialHelper(
  WidgetTester tester,
) async {
  await nawbarHelper(
    tester: tester,
    searchText: KTestText.field,
    hasMic: false,
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async => homeBoxHelper(tester),
  );

  await listQuestionHelper(tester);

  await feedbackHelper(tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.email,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.buttonClear,
  );

  await footerHelper(tester);
}
