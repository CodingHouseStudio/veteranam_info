import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> employeeRespondPumpAppHelper({
  required IWorkRepository mockWorkRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerEmployeeRespondBloc(mockWorkRepository: mockWorkRepository);
  await tester.pumpApp(
    const EmployeeRespondScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.employeeRespond.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerEmployeeRespondBloc({
  required IWorkRepository mockWorkRepository,
}) {
  final employeeRespondBloc = EmployeeRespondBloc(
    employeeRespondRepository: mockWorkRepository,
  );
  if (GetIt.I.isRegistered<EmployeeRespondBloc>()) {
    GetIt.I.unregister<EmployeeRespondBloc>();
  }
  GetIt.I.registerSingleton<EmployeeRespondBloc>(employeeRespondBloc);
}
