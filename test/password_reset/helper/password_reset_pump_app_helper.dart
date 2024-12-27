import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/password_reset/bloc/check_code/check_verification_code_cubit.dart';
import 'package:veteranam/components/password_reset/bloc/form/password_reset_bloc.dart';
import 'package:veteranam/components/password_reset/view/password_reset_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> passwordResetPumpAppHelper({
  required WidgetTester tester,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  MockGoRouter? mockGoRouter,
  String? code = KTestVariables.code,
}) async {
  _registerPasswordResetBloc(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerCheckVerificationCodeCubit(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );

  await tester.pumpApp(
    PasswordResetScreen(
      code: code,
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
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final pwResetEmailBloc = PasswordResetBloc(
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<PasswordResetBloc>()) {
    GetIt.I.unregister<PasswordResetBloc>();
  }
  GetIt.I.registerSingleton<PasswordResetBloc>(pwResetEmailBloc);
}

void _registerCheckVerificationCodeCubit({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  // final checkVerificationCodeCubit = CheckVerificationCodeCubit(
  //   appAuthenticationRepository: mockAppAuthenticationRepository,
  // );
  if (GetIt.I.isRegistered<CheckVerificationCodeCubit>()) {
    GetIt.I.unregister<CheckVerificationCodeCubit>();
  }
  GetIt.I.registerFactoryParam<CheckVerificationCodeCubit, String?, void>(
    (code, voidValue) => CheckVerificationCodeCubit(
      appAuthenticationRepository: mockAppAuthenticationRepository,
      code: code,
    ),
  );
  // GetIt.I.registerSingleton<CheckVerificationCodeCubit>(
  //   checkVerificationCodeCubit,
  // );
}
