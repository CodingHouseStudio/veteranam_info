import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> informationPumpAppHelper({
  required IInformationRepository mockInformationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerInformationBloc(
    mockInformationRepository: mockInformationRepository,
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
