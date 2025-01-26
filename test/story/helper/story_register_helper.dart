import 'package:mockito/mockito.dart';
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart';
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

  _registerBloc();
}

void _registerBloc() {
  // StoryWatcherBloc
  registerFactory<StoryWatcherBloc>(
    () => StoryWatcherBloc(
      storyRepository: mockStoryRepository,
    ),
  );

  // AuthenticationBloc
  registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: mockAuthenticationRepository,
    ),
  );
}
