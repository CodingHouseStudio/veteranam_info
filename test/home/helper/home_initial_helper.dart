import 'package:flutter_test/flutter_test.dart';

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

  await homeBoxHelper(tester);

  await listQuestionHelper(tester);

  await feedbackHelper(tester);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown1000,
  );

  await footerHelper(tester);
}
