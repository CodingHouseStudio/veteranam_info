part of 'body/feedback_body_widget.dart';

List<Widget> _fieldWidgetList({
  required bool isDesk,
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController messageController,
}) =>
    [
      if (isDesk)
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                widgetKey: KWidgetkeys.screen.feedback.nameField,
                errorText: context
                    .read<FeedbackBloc>()
                    .state
                    .name
                    .error
                    .value(context),
                showErrorText: context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.invalidData,
                controller: nameController,
                onChanged: (value) => context.read<FeedbackBloc>().add(
                      FeedbackEvent.nameUpdated(value),
                    ),
                labelText: context.l10n.name,
                isDesk: isDesk,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: TextFieldWidget(
                widgetKey: KWidgetkeys.screen.feedback.emailField,
                showErrorText: context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.invalidData,
                errorText: context
                    .read<FeedbackBloc>()
                    .state
                    .email
                    .error
                    .value(context),
                controller: emailController,
                onChanged: (value) => context.read<FeedbackBloc>().add(
                      FeedbackEvent.emailUpdated(value),
                    ),
                labelText: context.l10n.email,
                isDesk: isDesk,
              ),
            ),
          ],
        )
      else ...[
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.feedback.nameField,
          showErrorText: context.read<FeedbackBloc>().state.formState ==
              FeedbackEnum.invalidData,
          errorText:
              context.read<FeedbackBloc>().state.name.error.value(context),
          controller: nameController,
          onChanged: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.nameUpdated(value),
              ),
          labelText: context.l10n.name,
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox16,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.feedback.emailField,
          showErrorText: context.read<FeedbackBloc>().state.formState ==
              FeedbackEnum.invalidData,
          errorText:
              context.read<FeedbackBloc>().state.email.error.value(context),
          controller: emailController,
          onChanged: (value) => context.read<FeedbackBloc>().add(
                FeedbackEvent.emailUpdated(value),
              ),
          labelText: context.l10n.email,
          isDesk: isDesk,
        ),
      ],
      KSizedBox.kHeightSizedBox16,
      MessageFieldWidget(
        key: KWidgetkeys.screen.feedback.messageField,
        showErrorText: context.read<FeedbackBloc>().state.formState ==
            FeedbackEnum.invalidData,
        errorText:
            context.read<FeedbackBloc>().state.message.error.value(context),
        changeMessage: (value) => context.read<FeedbackBloc>().add(
              FeedbackEvent.messageUpdated(value),
            ),
        controller: messageController,
        labelText: context.l10n.writeYourMessage,
        isDesk: isDesk,
      ),
      Text(
        context.l10n.feedbackFormSubtitle,
        key: KWidgetkeys.screen.feedback.buttonText,
        style: AppTextStyle.materialThemeBodySmall,
      ),
      KSizedBox.kHeightSizedBox16,
      DoubleButtonWidget(
        widgetKey: KWidgetkeys.screen.feedback.button,
        text: context.l10n.sendMessage,
        isDesk: isDesk,
        onPressed: () =>
            context.read<FeedbackBloc>().add(const FeedbackEvent.save()),
        mobVerticalTextPadding: KPadding.kPaddingSize16,
        mobIconPadding: KPadding.kPaddingSize16,
        darkMode: true,
      ),
    ];
