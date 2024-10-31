import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart';
import 'package:veteranam/components/story/view/story_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> storyPumpAppHelper({
  required AuthenticationRepository mockAuthenticationRepository,
  required IStoryRepository mockStoryRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  _registerStoryBloc(mockStoryRepository: mockStoryRepository);
  await tester.pumpApp(const StoryScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.story.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerStoryBloc({
  required IStoryRepository mockStoryRepository,
}) {
  final storyBloc = StoryWatcherBloc(
    storyRepository: mockStoryRepository,
  );
  if (GetIt.I.isRegistered<StoryWatcherBloc>()) {
    GetIt.I.unregister<StoryWatcherBloc>();
  }
  GetIt.I.registerSingleton<StoryWatcherBloc>(storyBloc);
}

void _registerAuthenticationBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}
