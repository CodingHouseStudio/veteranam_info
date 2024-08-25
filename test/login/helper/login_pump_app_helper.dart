import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> loginPumpAppHelper({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerLoginBloc(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerAuthenticationServicesCubit(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  await tester.pumpApp(const LoginScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.login.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerLoginBloc({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final loginBloc = LoginBloc(
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<LoginBloc>()) {
    GetIt.I.unregister<LoginBloc>();
  }
  GetIt.I.registerSingleton<LoginBloc>(loginBloc);
}

void _registerAuthenticationServicesCubit({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final authenticationServicesCubit = AuthenticationServicesCubit(
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationServicesCubit>()) {
    GetIt.I.unregister<AuthenticationServicesCubit>();
  }
  GetIt.I.registerSingleton<AuthenticationServicesCubit>(
    authenticationServicesCubit,
  );
}
