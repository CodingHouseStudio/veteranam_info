import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/login/bloc/login_bloc.dart';
import 'package:veteranam/components/login/view/login_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> loginPumpAppHelper({
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerLoginBloc(
    mockAppAuthenticationRepository: mockAuthenticationRepository,
  );
  _registerAuthenticationServicesCubit(
    mockAppAuthenticationRepository: mockAuthenticationRepository,
  );
  await tester.pumpApp(const LoginScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.login.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerLoginBloc({
  required AuthenticationRepository mockAppAuthenticationRepository,
}) {
  final loginBloc = LoginBloc(
    authenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<LoginBloc>()) {
    GetIt.I.unregister<LoginBloc>();
  }
  GetIt.I.registerSingleton<LoginBloc>(loginBloc);
}

void _registerAuthenticationServicesCubit({
  required AuthenticationRepository mockAppAuthenticationRepository,
}) {
  final authenticationServicesCubit = AuthenticationServicesCubit(
    authenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationServicesCubit>()) {
    GetIt.I.unregister<AuthenticationServicesCubit>();
  }
  GetIt.I.registerSingleton<AuthenticationServicesCubit>(
    authenticationServicesCubit,
  );
}
