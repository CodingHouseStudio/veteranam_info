import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart';

class StoryAddBlocprovider extends StatelessWidget {
  const StoryAddBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<StoryAddBloc>(),
      child: childWidget,
    );
  }
}
