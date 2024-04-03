import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cardAddImageHelper({
  required WidgetTester tester,
  required String image,
  List<String>? detailButtonText,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.cardAddImage.widget),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardAddImage.widget),
      matching: find.image(
        CachedNetworkImageProvider(
          image,
        ),
      ),
    ),
    findsOneWidget,
  );

  await cardTextDetailEvaluateHelper(
    tester: tester,
    detailButtonText: detailButtonText,
  );
}
