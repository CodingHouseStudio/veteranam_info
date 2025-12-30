import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/questions_form/bloc/user_role_bloc.dart';

class QuestionFormBlocprovider extends StatelessWidget {
  const QuestionFormBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<UserRoleBloc>(),
      child: childWidget,
    );
  }
}
