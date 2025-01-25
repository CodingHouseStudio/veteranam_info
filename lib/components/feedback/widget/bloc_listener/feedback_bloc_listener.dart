import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FeedbackBlocListener extends StatelessWidget {
  const FeedbackBlocListener({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FeedbackBloc, FeedbackState>(
          listenWhen: (previous, current) =>
              current.failure != null || current.failure != previous.failure,
          listener: (context, state) {
            context.dialog.showSnackBardTextDialog(
              state.failure?.value(context),
            );
          },
        ),
        const BlocListener<UrlCubit, UrlEnum?>(
          listener: UrlCubitExtension.listener,
        ),
        if (!Config.isWeb)
          BlocListener<AppVersionCubit, AppVersionState>(
            listener: (context, state) => context.dialog.showMobUpdateAppDialog(
              hasNewVersion: state.mobHasNewBuild,
            ),
          ),
      ],
      child: childWidget,
    );
  }
}
