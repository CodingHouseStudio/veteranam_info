import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late UserRepository mockUserRepository;
late IDataPickerRepository mockDataPickerRepository;
late AuthenticationRepository mockAuthenticationRepository;
late StreamController<User> profileStream;
// late XFile image;
void profileWidgetTestRegister() {
  mockUserRepository = MockUserRepository();
  mockDataPickerRepository = MockIDataPickerRepository();
  mockAuthenticationRepository = MockAuthenticationRepository();
  profileStream = StreamController()..add(KTestVariables.pureUser);
  // image = XFile(KTestVariables.imageModels.downloadURL);
  // mockAppAuthenticationRepository = MockAppAuthenticationRepository();

  when(mockUserRepository.currentUser).thenAnswer(
    (realInvocation) => KTestVariables.userWithoutPhoto,
  );
  when(mockUserRepository.currentUserSetting).thenAnswer(
    (realInvocation) => KTestVariables.userSettingModel,
  );
  when(mockUserRepository.user).thenAnswer(
    (realInvocation) => profileStream.stream,
  );
  when(
    mockUserRepository.updateUserData(
      nickname: KTestVariables.nicknameCorrect,
      image: KTestVariables.filePickerItem,
      user: KTestVariables.profileUserWithoutPhoto,
    ),
  ).thenAnswer(
    (realInvocation) async => const Right(true),
  );

  // when(imagePickerValue.pickImage(source: ImageSource.gallery)).
  // thenAnswer(
  //   (realInvocation) async => image,
  // );

  when(
    mockDataPickerRepository.getImage,
  ).thenAnswer(
    (realInvocation) async => KTestVariables.filePickerItem,
  );

  when(mockAuthenticationRepository.status).thenAnswer(
    (realInvocation) => Stream.value(AuthenticationStatus.authenticated),
  );
  when(mockAuthenticationRepository.currectAuthenticationStatus).thenAnswer(
    (realInvocation) => AuthenticationStatus.authenticated,
  );
  when(mockAuthenticationRepository.logOut()).thenAnswer(
    (realInvocation) async => const Right(true),
  );
  when(mockAuthenticationRepository.deleteUser()).thenAnswer(
    (realInvocation) async => const Right(true),
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockUserRepository);
  registerSingleton(mockDataPickerRepository);
  registerSingleton(mockAuthenticationRepository);
}
