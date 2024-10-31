import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart';

class WorkEmployeeBlocprovider extends StatelessWidget {
  const WorkEmployeeBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<WorkEmployeeWatcherBloc>()
        ..add(
          const WorkEmployeeWatcherEvent.started(),
        ),
      child: childWidget,
    );
  }
}
