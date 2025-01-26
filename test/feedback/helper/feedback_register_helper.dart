import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
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

  _registerBloc();
}

void _registerBloc() {
  // FeedbackBloc
  registerFactory<FeedbackBloc>(
    () => FeedbackBloc(
      feedbackRepository: mockFeedbackRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
    ),
  );

  // UrlCubit
  registerFactory<UrlCubit>(
    () => UrlCubit(
      urlRepository: mockUrlRepository,
    ),
  );
}
