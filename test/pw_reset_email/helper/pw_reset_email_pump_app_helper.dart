import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> pwResetEmailPumpAppHelper({
  required WidgetTester tester,
  required AuthenticationRepository mockAuthenticationRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerPwResetEmailBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );

  await tester.pumpApp(
    const PwResetEmailScreen(
      email: KTestText.userEmailIncorrect,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerPwResetEmailBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final pwResetEmailBloc = PwResetEmailBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<PwResetEmailBloc>()) {
    GetIt.I.unregister<PwResetEmailBloc>();
  }
  GetIt.I.registerSingleton<PwResetEmailBloc>(pwResetEmailBloc);
}
