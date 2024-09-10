import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> investorsPumpAppHelper({
  required IInvestorsRepository mockInvestorsRepository,
  required IReportRepository mockReportRepository,
  required AuthenticationRepository mockAuthenticationRepository,
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
  _registerAuthenticationBloc(
    mockAuthenticationRepository,
  );
  _registerUrlCubit(mockUrlRepository);
  await tester.pumpApp(const InvestorsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.investors.screen),
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
  final reportBloc = ReportBloc(
    reportRepository: mockReportRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<ReportBloc>()) {
    GetIt.I.unregister<ReportBloc>();
  }
  GetIt.I.registerSingleton<ReportBloc>(reportBloc);
}

void _registerAuthenticationBloc(
  AuthenticationRepository mockAuthenticationRepository,
) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
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
