import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> signUpPumpAppHelper({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerAuthenticationBloc(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );

  await tester.pumpApp(
    const SignUpScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.signUp.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerAuthenticationBloc({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final signUpBloc = SignUpBloc(
    iAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<SignUpBloc>()) {
    GetIt.I.unregister<SignUpBloc>();
  }
  GetIt.I.registerSingleton<SignUpBloc>(signUpBloc);
}
