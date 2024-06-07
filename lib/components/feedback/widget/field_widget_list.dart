part of 'body/feedback_body_widget.dart';

List<Widget> _fieldWidgetList({
  required bool isDesk,
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController messageController,
}) =>
    [
      Row(
        children: [
          Expanded(
            child: TextFieldWidget(
              widgetKey: KWidgetkeys.widget.feedback.fieldName,
              errorText: context.read<FeedbackBloc>().state.formState ==
                      FeedbackEnum.invalidData
                  ? context.read<FeedbackBloc>().state.name.error.value(context)
                  : null,
              controller: nameController,
              onChanged: (value) => context.read<FeedbackBloc>().add(
                    FeedbackEvent.nameUpdated(value),
                  ),
              hintText: context.l10n.name,
              isDesk: isDesk,
            ),
          ),
          KSizedBox.kWidthSizedBox24,
          Expanded(
            child: TextFieldWidget(
              widgetKey: KWidgetkeys.widget.feedback.fieldEmail,
              errorText: context.read<FeedbackBloc>().state.formState ==
                      FeedbackEnum.invalidData
                  ? context
                      .read<FeedbackBloc>()
                      .state
                      .email
                      .error
                      .value(context)
                  : null,
              controller: emailController,
              onChanged: (value) => context.read<FeedbackBloc>().add(
                    FeedbackEvent.emailUpdated(value),
                  ),
              hintText: context.l10n.email,
              isDesk: isDesk,
            ),
          ),
        ],
      ),
      KSizedBox.kHeightSizedBox16,
      MessageFieldWidget(
        key: KWidgetkeys.widget.feedback.fieldMessage,
        errorText: context.read<FeedbackBloc>().state.formState ==
                FeedbackEnum.invalidData
            ? context.read<FeedbackBloc>().state.message.error.value(context)
            : null,
        changeMessage: (value) => context.read<FeedbackBloc>().add(
              FeedbackEvent.messageUpdated(value),
            ),
        controller: messageController,
        hintText: context.l10n.writeYourMessage,
        isDesk: isDesk,
      ),
      KSizedBox.kHeightSizedBox16,
      Text(
        context.l10n.feedbackFormSubtitle,
        style: AppTextStyle.materialThemeBodySmall,
      ),
      KSizedBox.kHeightSizedBox16,
      DoubleButtonWidget(
        widgetKey: const Key(''),
        text: context.l10n.sendMessage,
        isDesk: isDesk,
        onPressed: () =>
            context.read<FeedbackBloc>().add(const FeedbackEvent.save()),
        color: AppColors.materialThemeBlack,
        textColor: AppColors.materialThemeWhite,
      ),
    ];
