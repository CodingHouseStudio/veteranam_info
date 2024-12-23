import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart';
import 'package:veteranam/components/sign_up/view/sign_up_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> signUpPumpAppHelper({
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  _registerAuthenticationServiceCubit(
    mockAuthenticationRepository: mockAuthenticationRepository,
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
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final signUpBloc = SignUpBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<SignUpBloc>()) {
    GetIt.I.unregister<SignUpBloc>();
  }
  GetIt.I.registerSingleton<SignUpBloc>(signUpBloc);
}

void _registerAuthenticationServiceCubit({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final authenticationServicesCubit = AuthenticationServicesCubit(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationServicesCubit>()) {
    GetIt.I.unregister<AuthenticationServicesCubit>();
  }
  GetIt.I.registerSingleton<AuthenticationServicesCubit>(
    authenticationServicesCubit,
  );
}
