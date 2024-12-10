import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeBlocprovider extends StatelessWidget {
  const HomeBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<HomeWatcherBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<AppVersionCubit>(),
        ),
      ],
      child: childWidget,
    );
  }
}
