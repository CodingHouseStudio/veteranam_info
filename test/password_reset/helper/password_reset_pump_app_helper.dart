import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> passwordResetPumpAppHelper({
  required WidgetTester tester,
  required AuthenticationRepository mockAuthenticationRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerPasswordResetBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );

  await tester.pumpApp(
    const PasswordResetScreen(
      code: KTestText.code,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.passwordReset.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerPasswordResetBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final pwResetEmailBloc = PasswordResetBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<PasswordResetBloc>()) {
    GetIt.I.unregister<PasswordResetBloc>();
  }
  GetIt.I.registerSingleton<PasswordResetBloc>(pwResetEmailBloc);
}
