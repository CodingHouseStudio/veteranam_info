import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/consent_dialog/bloc/consent_dialog_bloc.dart';

class ConsentDialogBlocprovider extends StatelessWidget {
  const ConsentDialogBlocprovider({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<ConsentDialogBloc>(),
      child: child,
    );
  }
}
