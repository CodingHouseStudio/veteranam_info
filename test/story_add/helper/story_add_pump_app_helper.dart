import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> storyAddPumpAppHelper({
  required IStoryRepository mockStoryRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  required DataPickerRepository mockDataPickerRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerStoryAddBloc(
    mockStoryRepository: mockStoryRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    mockDataPickerRepository: mockDataPickerRepository,
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
  required DataPickerRepository mockDataPickerRepository,
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
