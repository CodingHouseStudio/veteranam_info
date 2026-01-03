import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart';

class StoryBlocprovider extends StatelessWidget {
  const StoryBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<StoryWatcherBloc>()
        ..add(const StoryWatcherEvent.started()),
      child: childWidget,
    );
  }
}
