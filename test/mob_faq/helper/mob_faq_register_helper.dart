import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IFaqRepository mockFaqRepository;
void mobFaqWidgetTestRegister() {
  Config.testIsWeb = false;
  ExtendedDateTime.current = KTestVariables.dateTime;
  ExtendedDateTime.id = KTestVariables.feedbackModel.id;
  PlatformEnumFlutter.isWebDesktop = true;
  mockFaqRepository = MockIFaqRepository();

  registerSingleton(mockFaqRepository);
}
