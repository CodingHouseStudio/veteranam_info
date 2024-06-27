import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> informationPumpAppHelper({
  required IInformationRepository mockInformationRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerInformationBloc(
    mockInformationRepository: mockInformationRepository,
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

void _registerInformationBloc({
  required IInformationRepository mockInformationRepository,
}) {
  final informationBloc = InformationWatcherBloc(
    informationRepository: mockInformationRepository,
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
