import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late UserRepository mockUserRepository;
void questionFormWidgetTestRegister() {
  mockUserRepository = MockUserRepository();
  when(mockUserRepository.currentUser).thenAnswer(
    (realInvocation) => KTestVariables.userWithoutPhoto,
  );
  when(mockUserRepository.currentUserSetting).thenAnswer(
    (realInvocation) => UserSetting.empty,
  );
  when(
    mockUserRepository.updateUserSetting(
      userSetting: UserSetting.empty.copyWith(
        userRole: UserRole.veteran,
      ),
    ),
  ).thenAnswer(
    (realInvocation) async => const Right(true),
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockUserRepository);
}
