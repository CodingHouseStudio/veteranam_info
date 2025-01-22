import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> advancedFilterAppliedHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await advancedFilterHelper(tester);

  await tester.tap(
    find.byKey(DiscountsFilterKeys.mobAppliedButton),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.pop(),
  ).called(1);
}
