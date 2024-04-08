import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> newsCardHelper({
  required WidgetTester tester,
  String? image,
}) async {
  expect(find.byKey(KWidgetkeys.widget.newsCard.date), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.newsCard.tags), findsWidgets);

  if (image != null) {
    await cardAddImageHelper(
      tester: tester,
      image: image,
    );
  } else {
    await cardTextDetailEvaluateHelper(
      tester,
    );
  }
}
