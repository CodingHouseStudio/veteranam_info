import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

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
