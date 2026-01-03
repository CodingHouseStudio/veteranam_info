import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IAppAuthenticationRepository mockAppAuthenticationRepository;
void mardownFileWidgetTestRegister() {
  KTest.cashe = false;
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();

  when(
    mockAppAuthenticationRepository.currentUserSetting,
  ).thenAnswer(
    (realInvocation) => KTestVariables.userSetting,
  );

  registerSingleton(
    mockAppAuthenticationRepository,
  );
}
