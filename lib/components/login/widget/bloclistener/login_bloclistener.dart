import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/shared/shared_dart.dart';
import 'package:veteranam/shared/widget/dialogs_widget.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationServicesCubit,
        AuthenticationServicesState>(
      listener: (context, state) =>
          context.dialog.showAuthenticationServiceDialog(
        state.status,
        failure: state.failure,
      ),
      child: child,
    );
  }
}
