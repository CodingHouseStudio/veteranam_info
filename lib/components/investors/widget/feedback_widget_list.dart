part of 'body/investors_body_widget.dart';

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
      if (isDesk) KSizedBox.kHeightSizedBox40 else KSizedBox.kHeightSizedBox24,
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
          context: context,
          isDesk: isDesk,
          title: context.l10n.investors,
          subtitle: context.l10n.investorsSubtitle,
          messageHint: context.l10n.writeYourSuggenstions,
          nameController: nameController,
          emailController: emailController,
          messageController: messageController,
          feedbackKey: feedbackKey,
        ),
      if (isDesk) KSizedBox.kHeightSizedBox56 else KSizedBox.kHeightSizedBox40,
      ...TitleWidget.titleWidgetList(
        title: context.l10n.funds,
        titleKey: KWidgetkeys.screen.investors.fundTitle,
        subtitle: context.l10n.fundsSubtitle,
        subtitleKey: KWidgetkeys.screen.investors.fundSubtitle,
        isDesk: isDesk,
      ),
      KSizedBox.kHeightSizedBox56,
    ];
