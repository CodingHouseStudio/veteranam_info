import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> newsCardHelper({
  required WidgetTester tester,
  String? image,
}) async {
  expect(find.byKey(KWidgetkeys.widget.newsCard.date), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.newsCard.title), findsWidgets);

  if (image != null) {
    await cardAddImageHelper(
      tester: tester,
      image: image,
    );
  } else {
    await cardTextDetailEvaluateHelper(
      tester: tester,
    );
  }

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      if (image != null) {
        await cardAddImageHelper(
          tester: tester,
          image: image,
        );
      } else {
        await cardTextDetailEvaluateHelper(
          tester: tester,
        );
      }
    },
  );
}
