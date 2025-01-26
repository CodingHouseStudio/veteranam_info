import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IFeedbackRepository mockFeedbackRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
late UserRepository mockUserRepository;
// late BuildRepository mockBuildRepository;
void mobSettingWidgetTestRegister() {
  Config.testIsWeb = false;
  ExtendedDateTime.id = KTestVariables.id;
  ExtendedDateTime.current = KTestVariables.dateTime;

  mockFeedbackRepository = MockIFeedbackRepository();
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();
  mockUserRepository = MockUserRepository();
  // mockBuildRepository = MockBuildRepository();

  when(
    mockAppAuthenticationRepository.currentUser,
  ).thenAnswer((realInvocation) => KTestVariables.user);
  // when(mockBuildRepository.getBuildInfo()).thenAnswer(
  //   (invocation) async => BuildRepository.defaultValue,
  // );

  // when(
  //   mockFeedbackRepository.sendMobFeedback(
  //     feedback: FeedbackModel(
  //       id: KTestVariables.id,
  //       message: KTestVariables.field,
  //       guestId: KTestVariables.user.id,
  //       guestName: null,
  //       email: null,
  //       timestamp: KTestVariables.dateTime,
  //     ),
  //     image: Uint8List(1),
  //   ),
  // ).thenAnswer(
  //   (realInvocation) async => const Right(true),
  // );

  when(mockUserRepository.currentUser).thenAnswer(
    (realInvocation) => User.empty,
  );
  when(mockUserRepository.currentUserSetting).thenAnswer(
    (realInvocation) => UserSetting.empty,
  );
  when(
    mockUserRepository.updateUserSetting(
      userSetting: UserSetting.empty.copyWith(locale: Language.english),
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );
  when(
    mockUserRepository.updateUserSetting(
      userSetting: UserSetting.empty.copyWith(locale: Language.ukrain),
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockFeedbackRepository);
  registerSingleton(mockAppAuthenticationRepository);
  registerSingleton(mockUserRepository);
}
