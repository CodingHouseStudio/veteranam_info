import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> submitedHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await fieldCorrectHelper(tester);

  verify(
    () => mockGoRouter.goNamed(KRoute.stories.name),
  ).called(1);
}
