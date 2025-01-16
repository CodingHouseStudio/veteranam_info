import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/investors/view/investors_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> investorsPumpAppHelper({
  required IInvestorsRepository mockInvestorsRepository,
  required IReportRepository mockReportRepository,
  required UserRepository mockUserRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required IUrlRepository mockUrlRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerReportBloc(
    mockReportRepository: mockReportRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerInvestorsBloc(
    mockInvestorsRepository: mockInvestorsRepository,
    // mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    // mockReportRepository: mockReportRepository,
  );
  _registerUserWatcherBloc(
    mockUserRepository,
  );
  _registerUrlCubit(mockUrlRepository);
  await tester.pumpApp(const InvestorsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(InvestorsKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerInvestorsBloc({
  required IInvestorsRepository mockInvestorsRepository,
  // required IAppAuthenticationRepository mockAppAuthenticationRepository,
  // required IReportRepository mockReportRepository,
}) {
  final investorsBloc = InvestorsWatcherBloc(
    investorsRepository: mockInvestorsRepository,
    // reportRepository: mockReportRepository,
    // appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<InvestorsWatcherBloc>()) {
    GetIt.I.unregister<InvestorsWatcherBloc>();
  }
  GetIt.I.registerSingleton<InvestorsWatcherBloc>(investorsBloc);
}

void _registerReportBloc({
  required IReportRepository mockReportRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  if (GetIt.I.isRegistered<ReportBloc>()) {
    GetIt.I.unregister<ReportBloc>();
  }
  GetIt.I.registerFactoryParam<ReportBloc, String, CardEnum>(
    (cardId, card) => ReportBloc(
      reportRepository: mockReportRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
      cardId: KTestVariables.id,
      card: CardEnum.funds,
    ),
  );
}

void _registerUserWatcherBloc(
  UserRepository mockUserRepository,
) {
  final userWatcherBloc = UserWatcherBloc(
    userRepository: mockUserRepository,
  );
  if (GetIt.I.isRegistered<UserWatcherBloc>()) {
    GetIt.I.unregister<UserWatcherBloc>();
  }
  GetIt.I.registerSingleton<UserWatcherBloc>(userWatcherBloc);
}

void _registerUrlCubit(
  IUrlRepository mockUrlRepository,
) {
  final urlCubit = UrlCubit(
    urlRepository: mockUrlRepository,
  );
  if (GetIt.I.isRegistered<UrlCubit>()) {
    GetIt.I.unregister<UrlCubit>();
  }
  GetIt.I.registerSingleton<UrlCubit>(urlCubit);
}
