import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> loginPumpAppHelper({
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerLoginBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  await tester.pumpApp(const LoginScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.login.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerLoginBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final loginBloc = LoginBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<LoginBloc>()) {
    GetIt.I.unregister<LoginBloc>();
  }
  GetIt.I.registerSingleton<LoginBloc>(loginBloc);
}
