import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

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
    iAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<MyStoryWatcherBloc>()) {
    GetIt.I.unregister<MyStoryWatcherBloc>();
  }
  GetIt.I.registerSingleton<MyStoryWatcherBloc>(
    myStoryWatcherBloc,
  );
}
