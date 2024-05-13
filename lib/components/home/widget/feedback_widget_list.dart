part of 'body/home_body_widget.dart';

List<Widget> _feedbackWidgetList({
  required BuildContext context,
  required bool isDesk,
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController messageController,
  required GlobalKey feedbackKey,
  required GlobalKey feedbackBoxKey,
}) =>
    [
      if (isDesk) KSizedBox.kHeightSizedBox160 else KSizedBox.kHeightSizedBox40,
      SizedBox.shrink(
        key: feedbackKey,
      ),
      if (context.read<FeedbackBloc>().state.formState ==
              FeedbackEnum.success ||
          context.read<FeedbackBloc>().state.formState ==
              FeedbackEnum.sendingMessage)
        FeedbackBoxWidget(
          key: feedbackBoxKey,
          isDesk: isDesk,
          sendAgain: () => context
              .read<FeedbackBloc>()
              .add(const FeedbackEvent.sendignMessageAgain()),
          feedbackBoxKey: feedbackBoxKey,
        )
      else
        ...FeedbackWidget.feedbackWidgetList(
          isDesk: isDesk,
          context: context,
          nameController: nameController,
          emailController: emailController,
          messageController: messageController,
          feedbackKey: feedbackKey,
        ),
      if (isDesk) KSizedBox.kHeightSizedBox160 else KSizedBox.kHeightSizedBox10,
    ];
