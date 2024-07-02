import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> storyAddPumpAppHelper({
  required IStoryRepository mockStoryRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerStoryAddBloc(
    mockStoryRepository: mockStoryRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  await tester.pumpApp(const StoryAddScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.storyAdd.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerStoryAddBloc({
  required IStoryRepository mockStoryRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final storyAddBloc = StoryAddBloc(
    storyRepository: mockStoryRepository,
    iAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<StoryAddBloc>()) {
    GetIt.I.unregister<StoryAddBloc>();
  }
  GetIt.I.registerSingleton<StoryAddBloc>(storyAddBloc);
}
