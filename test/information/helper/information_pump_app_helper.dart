import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart';
import 'package:veteranam/components/information/view/information_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> informationPumpAppHelper({
  required IInformationRepository mockInformationRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required IReportRepository mockReportRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerInformationBloc(
    mockInformationRepository: mockInformationRepository,
    // mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    // mockReportRepository: mockReportRepository,
  );
  _registerReportBloc(
    mockReportRepository: mockReportRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  await tester.pumpApp(const InformationScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.information.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
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

void _registerInformationBloc({
  required IInformationRepository mockInformationRepository,
  // required IAppAuthenticationRepository mockAppAuthenticationRepository,
  // required IReportRepository mockReportRepository,
}) {
  final informationBloc = InformationWatcherBloc(
    informationRepository: mockInformationRepository,
    // reportRepository: mockReportRepository,
    // appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<InformationWatcherBloc>()) {
    GetIt.I.unregister<InformationWatcherBloc>();
  }
  GetIt.I.registerSingleton<InformationWatcherBloc>(informationBloc);
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
