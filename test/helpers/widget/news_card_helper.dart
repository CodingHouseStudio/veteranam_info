import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> newsCardHelper({
  required WidgetTester tester,
  String? image,
}) async {
  expect(find.byKey(KWidgetkeys.newsCardKeys.date), findsOneWidget);

  expect(find.byKey(KWidgetkeys.newsCardKeys.title), findsOneWidget);

  if (image != null) {
    await cardAddImageHelper(
      tester: tester,
      image: image,
      detailButtonText: KAppText.newsDetailButton,
    );
  } else {
    await cardTextDetailEvaluateHelper(
      tester: tester,
      detailButtonText: KAppText.newsDetailButton,
    );
  }
}
