import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

late IStoryRepository mockStoryRepository;
late AuthenticationRepository mockAuthenticationRepository;
void storyWidgetTestRegister() {
  ExtendedDateTime.current = KTestVariables.dateTime;
  ExtendedDateTime.id = '';
  mockStoryRepository = MockIStoryRepository();
  mockAuthenticationRepository = MockAuthenticationRepository();
  when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
    (realInvocation) => AuthenticationStatus.authenticated,
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockStoryRepository);
  registerSingleton(mockAuthenticationRepository);
}
