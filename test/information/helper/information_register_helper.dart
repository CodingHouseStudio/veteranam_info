import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IInformationRepository mockInformationRepository;
late UserRepository mockUserRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
late IReportRepository mockReportRepository;
void informatonWidgetTestRegister() {
  ExtendedDateTime.current = KTestVariables.dateTime;
  ExtendedDateTime.id = '';
  PlatformEnumFlutter.isWebDesktop = false;
  mockInformationRepository = MockIInformationRepository();
  mockUserRepository = MockUserRepository();
  when(mockUserRepository.currentUser).thenAnswer(
    (realInvocation) => User.empty,
  );
  when(mockUserRepository.currentUserSetting).thenAnswer(
    (realInvocation) => UserSetting.empty,
  );
  // when(mockUserRepository.isAnonymously).thenAnswer(
  //   (realInvocation) => true,
  // );
  for (var i = 0; i < 5; i++) {
    when(
      mockInformationRepository.updateLikeCount(
        informationModel: KTestVariables.informationModelItems.elementAt(i),
        isLiked: true,
      ),
    ).thenAnswer(
      (invocation) async => const Right(true),
    );
    when(
      mockInformationRepository.updateLikeCount(
        informationModel: KTestVariables.informationModelItems.elementAt(i),
        isLiked: false,
      ),
    ).thenAnswer(
      (invocation) async => const Right(true),
    );
  }
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();
  when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    (invocation) => KTestVariables.user,
  );
  mockReportRepository = MockIReportRepository();
  when(
    mockReportRepository.getCardReportById(
      cardEnum: CardEnum.information,
      userId: KTestVariables.user.id,
    ),
  ).thenAnswer(
    (invocation) async => Right(KTestVariables.reportItems),
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockInformationRepository);
  registerSingleton(mockUserRepository);
  registerSingleton(mockAppAuthenticationRepository);
  registerSingleton(mockReportRepository);
}
