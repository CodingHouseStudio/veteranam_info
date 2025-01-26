import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IFeedbackRepository mockFeedbackRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
late IUrlRepository mockUrlRepository;
void feedbackWidgetTestRegister() {
  ExtendedDateTime.current = KTestVariables.dateTime;
  ExtendedDateTime.id = KTestVariables.feedbackModel.id;

  mockUrlRepository = MockIUrlRepository();
  mockFeedbackRepository = MockIFeedbackRepository();
  when(mockFeedbackRepository.sendFeedback(KTestVariables.feedbackModel))
      .thenAnswer(
    (invocation) async => const Right(true),
  );
  when(
    mockFeedbackRepository.checkUserNeedShowFeedback(KTestVariables.user.id),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();
  when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
    (realInvocation) => UserSetting.empty,
  );
  when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    (realInvocation) => KTestVariables.user,
  );
  when(mockUrlRepository.copy(KAppText.email)).thenAnswer(
    (invocation) async => const Right(true),
  );

  _registerRepository();
}

void _registerRepository() {
  registerSingleton(mockFeedbackRepository);
  registerSingleton(mockAppAuthenticationRepository);
  registerSingleton(mockUrlRepository);
}
