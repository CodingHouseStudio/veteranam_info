import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart';
import 'package:veteranam/components/work_employee/view/work_employee_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> workEmployeePumpAppHelper({
  required IWorkRepository mockWorkRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerWorkEmployeeBloc(mockWorkRepository: mockWorkRepository);
  await tester.pumpApp(const WorkEmployeeScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerWorkEmployeeBloc({required IWorkRepository mockWorkRepository}) {
  final workEmployeeWatcherBloc = WorkEmployeeWatcherBloc(
    workRepository: mockWorkRepository,
  );
  if (GetIt.I.isRegistered<WorkEmployeeWatcherBloc>()) {
    GetIt.I.unregister<WorkEmployeeWatcherBloc>();
  }
  GetIt.I.registerSingleton<WorkEmployeeWatcherBloc>(
    workEmployeeWatcherBloc,
  );
}
