import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class HomeBlocprovider extends StatelessWidget {
  const HomeBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<HomeWatcherBloc>()
            ..add(const HomeWatcherEvent.started()),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<FeedbackBloc>(),
        ),
      ],
      child: childWidget,
    );
  }
}
