import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';

class FeedbackBlocprovider extends StatelessWidget {
  const FeedbackBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<FeedbackBloc>(),
      child: childWidget,
    );
  }
}
