import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart';
import 'package:veteranam/components/my_story/view/my_story_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> myStoryPumpAppHelper({
  required IStoryRepository mockStoryRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerMyStoryBloc(
    mockStoryRepository: mockStoryRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );

  await tester.pumpApp(
    const ProfileMyStoryScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.myStory.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerMyStoryBloc({
  required IStoryRepository mockStoryRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final myStoryWatcherBloc = MyStoryWatcherBloc(
    storyRepository: mockStoryRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<MyStoryWatcherBloc>()) {
    GetIt.I.unregister<MyStoryWatcherBloc>();
  }
  GetIt.I.registerSingleton<MyStoryWatcherBloc>(
    myStoryWatcherBloc,
  );
}
