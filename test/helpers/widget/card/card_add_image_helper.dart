import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> cardAddImageHelper({
  required WidgetTester tester,
  required String image,
}) async {
  expect(
    find.byKey(CardAddImageKeys.widget),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(CardAddImageKeys.widget),
      matching: find.image(
        CachedNetworkImageProvider(
          image,
        ),
      ),
    ),
    findsOneWidget,
  );
}
