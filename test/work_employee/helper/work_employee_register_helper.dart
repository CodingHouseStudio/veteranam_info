import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IWorkRepository mockWorkRepository;
void workEmployeeWidgetTestRegister() {
  mockWorkRepository = MockIWorkRepository();

  registerFactory(
    () => WorkEmployeeWatcherBloc(
      workRepository: mockWorkRepository,
    ),
  );
}
