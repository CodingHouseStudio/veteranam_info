import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

late IAppAuthenticationRepository mockAppAuthenticationRepository;
void pwResetEmailTestWidgetRegister() {
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();

  registerSingleton(mockAppAuthenticationRepository);
}
