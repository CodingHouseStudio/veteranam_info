import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IInformationRepository mockInformationRepository;
void newsCardTestWidgetRegister() {
  mockInformationRepository = MockIInformationRepository();

  registerSingleton(mockInformationRepository);
}
