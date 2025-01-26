import 'package:mockito/mockito.dart';
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IStoryRepository mockStoryRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
void myStoryWidgetTestRegister() {
  mockStoryRepository = MockIStoryRepository();
  mockAppAuthenticationRepository = MockIAppAuthenticationRepository();

  when(mockAppAuthenticationRepository.currentUser)
      .thenAnswer((invocation) => KTestVariables.userWithoutPhoto);

  registerFactory(
    () => MyStoryWatcherBloc(
      storyRepository: mockStoryRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
    ),
  );
}
