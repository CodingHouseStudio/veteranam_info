import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IStoryRepository mockStoryRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
late IDataPickerRepository mockDataPickerRepository;
void storyAddWidgetTestRegister() {
  ExtendedDateTime.current = KTestVariables.storyModelItems.first.date;
  ExtendedDateTime.id = KTestVariables.storyModelItems.first.id;
  mockStoryRepository = MockIStoryRepository();
  mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
  mockDataPickerRepository = MockIDataPickerRepository();

  when(
    mockDataPickerRepository.getImage,
  ).thenAnswer(
    (realInvocation) async => KTestVariables.filePickerItem,
  );

  when(
    mockStoryRepository.addStory(
      imageItem: KTestVariables.filePickerItem,
      storyModel: KTestVariables.storyModelItems.first,
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );
  when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    (invocation) => KTestVariables.userWithoutPhoto,
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockStoryRepository);
  registerSingleton(mockAppAuthenticationRepository);
  registerSingleton(mockDataPickerRepository);
}
