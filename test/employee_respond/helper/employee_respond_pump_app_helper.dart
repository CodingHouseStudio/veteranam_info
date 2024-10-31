import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart';
import 'package:veteranam/components/employee_respond/view/employee_respond_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> employeeRespondPumpAppHelper({
  required IWorkRepository mockWorkRepository,
  required WidgetTester tester,
  required IDataPickerRepository mockDataPickerRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerEmployeeRespondBloc(
    mockWorkRepository: mockWorkRepository,
    mockDataPickerRepository: mockDataPickerRepository,
  );
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
  required IDataPickerRepository mockDataPickerRepository,
}) {
  final employeeRespondBloc = EmployeeRespondBloc(
    employeeRespondRepository: mockWorkRepository,
    dataPickerRepository: mockDataPickerRepository,
  );
  if (GetIt.I.isRegistered<EmployeeRespondBloc>()) {
    GetIt.I.unregister<EmployeeRespondBloc>();
  }
  GetIt.I.registerSingleton<EmployeeRespondBloc>(employeeRespondBloc);
}
