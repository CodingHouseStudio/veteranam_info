import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IInvestorsRepository mockInvestorsRepository;
late IReportRepository mockReportRepository;
late UserRepository mockUserRepository;
late IAppAuthenticationRepository mockAppAuthenticationRepository;
late IUrlRepository mockUrlRepository;
void investorsWidgetTestRegister() {
  ExtendedDateTime.current = KTestVariables.dateTime;
  ExtendedDateTime.id = '';
  Config.testIsWeb = true;

  mockInvestorsRepository = MockIInvestorsRepository();
  mockReportRepository = MockIReportRepository();
  mockUserRepository = MockUserRepository();
  mockAppAuthenticationRepository = MockAppAuthenticationRepository();
  mockUrlRepository = MockIUrlRepository();

  when(mockUserRepository.currentUser).thenAnswer(
    (realInvocation) => User.empty,
  );
  when(mockUserRepository.currentUserSetting).thenAnswer(
    (realInvocation) => UserSetting.empty,
  );
  // when(mockUserRepository.isAnonymously).thenAnswer(
  //   (realInvocation) => true,
  // );
  when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
    (realInvocation) => UserSetting.empty,
  );
  when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    (realInvocation) => KTestVariables.user,
  );
  when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
    (realInvocation) => true,
  );
  when(
    mockReportRepository.sendReport(
      KTestVariables.reportModel
          .copyWith(reasonComplaint: ReasonComplaint.other),
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );
  when(
    mockReportRepository.getCardReportById(
      cardEnum: CardEnum.funds,
      userId: KTestVariables.user.id,
    ),
  ).thenAnswer(
    (invocation) async => Right(KTestVariables.reportItems),
  );
  when(
    mockUrlRepository.launchUrl(
      url: KTestVariables.fundItems.first.projectsLink!,
    ),
  ).thenAnswer(
    (invocation) async => const Right(true),
  );

  _registerBloc();
}

void _registerBloc() {
  // InvestorsWatcherBloc
  registerFactory<InvestorsWatcherBloc>(
    () => InvestorsWatcherBloc(
      investorsRepository: mockInvestorsRepository,
    ),
  );

  // ReportBloc
  registerFactoryParam<ReportBloc, String, CardEnum>(
    (cardId, card) => ReportBloc(
      reportRepository: mockReportRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
      cardId: KTestVariables.id,
      card: CardEnum.funds,
    ),
  );

  // UserWatcherBloc
  registerFactory<UserWatcherBloc>(
    () => UserWatcherBloc(
      userRepository: mockUserRepository,
    ),
  );

  // UrlCubit
  registerFactory<UrlCubit>(
    () => UrlCubit(
      urlRepository: mockUrlRepository,
    ),
  );
}
