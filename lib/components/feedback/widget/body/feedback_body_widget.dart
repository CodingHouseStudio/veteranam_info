import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

part '../feedback_box_widget.dart';
part '../field_widget_list.dart';
part '../title_widget_list.dart';
part '../form_widget_list.dart';

class FeedbackBodyWidget extends StatefulWidget {
  const FeedbackBodyWidget({super.key});

  @override
  State<FeedbackBodyWidget> createState() => _FeedbackBodyWidgetState();
}

class _FeedbackBodyWidgetState extends State<FeedbackBodyWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController messageController;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        if (state.formState == FeedbackEnum.clear) {
          nameController.clear();
          emailController.clear();
          messageController.clear();
        }
        if (state.failure != null) {
          context.dialog.showSendErrorDialog(
            state.failure!.value(context),
          );
        }
      },
      buildWhen: (previous, current) =>
          current.failure != null || previous.formState != current.formState,
      builder: (context, state) {
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk}) => [
            ..._titleWidgetList(isDesk: isDesk, context: context),
            if (context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.success ||
                context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.sendingMessage)
              ..._feedbackBoxWidgetList(
                isDesk: isDesk,
                sendAgain: () => context
                    .read<FeedbackBloc>()
                    .add(const FeedbackEvent.sendignMessageAgain()),
                context: context,
              )
            else
              ..._formWidgegList(
                isDesk: isDesk,
                context: context,
                nameController: nameController,
                emailController: emailController,
                messageController: messageController,
              ),
            KSizedBox.kHeightSizedBox100,
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
