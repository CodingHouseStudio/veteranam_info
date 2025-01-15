import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart';
import 'package:veteranam/components/story_add/view/story_add_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> storyAddPumpAppHelper({
  required IStoryRepository mockStoryRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  required IDataPickerRepository mockDataPickerRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerStoryAddBloc(
    mockStoryRepository: mockStoryRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    mockDataPickerRepository: mockDataPickerRepository,
  );
  await tester.pumpApp(const StoryAddScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(StoryAddKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerStoryAddBloc({
  required IStoryRepository mockStoryRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required IDataPickerRepository mockDataPickerRepository,
}) {
  final storyAddBloc = StoryAddBloc(
    storyRepository: mockStoryRepository,
    iAppAuthenticationRepository: mockAppAuthenticationRepository,
    dataPickerRepository: mockDataPickerRepository,
  );
  if (GetIt.I.isRegistered<StoryAddBloc>()) {
    GetIt.I.unregister<StoryAddBloc>();
  }
  GetIt.I.registerSingleton<StoryAddBloc>(storyAddBloc);
}
