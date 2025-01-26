import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/markdown_file_dialog/view/markdown_file_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> markdownFileDialogPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const MarkdownFileDialog(
      ukFilePath: KAppText.ukPrivacyPolicyPath,
      enFilePath: KAppText.enPrivacyPolicyPath,
      startText: KTestVariables.field,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(PrivacyPolicyDialogKeys.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
