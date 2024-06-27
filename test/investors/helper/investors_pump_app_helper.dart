import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> investorsPumpAppHelper({
  required IInvestorsRepository mockInvestorsRepository,
  required IReportRepository mockReportRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerInvestorsBloc(mockInvestorsRepository: mockInvestorsRepository);
  _registerReportBloc(
    mockReportRepository: mockReportRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  await tester.pumpApp(const InvestorsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.investors.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerInvestorsBloc({
  required IInvestorsRepository mockInvestorsRepository,
}) {
  final investorsBloc =
      InvestorsWatcherBloc(investorsRepository: mockInvestorsRepository);
  if (GetIt.I.isRegistered<InvestorsWatcherBloc>()) {
    GetIt.I.unregister<InvestorsWatcherBloc>();
  }
  GetIt.I.registerSingleton<InvestorsWatcherBloc>(investorsBloc);
}

void _registerReportBloc({
  required IReportRepository mockReportRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final reportBloc = ReportBloc(
    reportRepository: mockReportRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<ReportBloc>()) {
    GetIt.I.unregister<ReportBloc>();
  }
  GetIt.I.registerSingleton<ReportBloc>(reportBloc);
}

void _registerAuthenticationBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}
