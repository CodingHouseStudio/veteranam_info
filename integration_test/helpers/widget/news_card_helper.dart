import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> newsCardHelper({
  required WidgetTester tester,
  String? image,
}) async {
  expect(find.byKey(NewsCardKeys.date), findsWidgets);

  expect(find.byKey(NewsCardKeys.title), findsWidgets);

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
