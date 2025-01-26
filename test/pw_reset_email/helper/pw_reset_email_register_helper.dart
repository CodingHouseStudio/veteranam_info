import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IAppAuthenticationRepository mockAppAuthenticationRepository;
void pwResetEmailTestWidgetRegister() {
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();

  registerFactory(
    () => PwResetEmailBloc(
      appAuthenticationRepository: mockAppAuthenticationRepository,
    ),
  );
}
