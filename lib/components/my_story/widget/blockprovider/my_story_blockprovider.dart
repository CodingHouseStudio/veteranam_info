import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart';

class MyStoryBlocprovider extends StatelessWidget {
  const MyStoryBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<MyStoryWatcherBloc>()
        ..add(
          const MyStoryWatcherEvent.started(),
        ),
      child: childWidget,
    );
  }
}
