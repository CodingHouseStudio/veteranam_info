import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsEditFormHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await discountsAddSendHelper(tester);

  await discountsAddMainHelper(tester: tester, hasField: false);

  await discountsAddSendHelper(tester);

  await discountsAddDetailHelper(tester: tester, hasField: false);

  await discountsAddSendHelper(tester);

  verify(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  ).called(1);
}
