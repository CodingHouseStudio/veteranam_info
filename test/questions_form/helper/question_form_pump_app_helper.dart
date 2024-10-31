import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/questions_form/view/questions_form_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> questionFormPumpAppHelper({
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  await tester.pumpApp(const QuestionsFormScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.questionsForm.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
}

void _registerAuthenticationBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}
