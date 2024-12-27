import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart';
import 'package:veteranam/components/pw_reset_email/view/pw_reset_email_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> pwResetEmailPumpAppHelper({
  required WidgetTester tester,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerPwResetEmailBloc(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );

  await tester.pumpApp(
    const PwResetEmailScreen(
      email: KTestVariables.userEmailIncorrect,
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
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final pwResetEmailBloc = PwResetEmailBloc(
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<PwResetEmailBloc>()) {
    GetIt.I.unregister<PwResetEmailBloc>();
  }
  GetIt.I.registerSingleton<PwResetEmailBloc>(pwResetEmailBloc);
}
