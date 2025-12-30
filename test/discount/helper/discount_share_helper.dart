import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/repositories/i_url_repository.dart';
import '../../test_dependency.dart';

Future<void> discountShareHelper({
  required WidgetTester tester,
  required IUrlRepository mockUrlRepository,
}) async {
  expect(
    find.byKey(DiscountKeys.shareButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountKeys.shareButton,
  );

  await tester.tap(find.byKey(DiscountKeys.shareButton));

  await tester.pumpAndSettle();

  verify(
    mockUrlRepository.share('/discounts/${KTestVariables.id}'),
  ).called(1);
}
