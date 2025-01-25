import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountsLoadingHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(find.byKey(DiscountsFilterKeys.loadingItems), findsWidgets);

      expect(find.byKey(DiscountsFilterKeys.eligibilitiesItems), findsNothing);

      expect(find.byKey(DiscountsFilterKeys.categoriesItems), findsNothing);

      expect(find.byKey(DiscountsFilterKeys.cityItems), findsNothing);
    },
  );
}
