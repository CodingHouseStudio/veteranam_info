import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

late IWorkRepository mockWorkRepository;
void workEmployeeWidgetTestRegister() {
  mockWorkRepository = MockIWorkRepository();

  registerSingleton(mockWorkRepository);
}
