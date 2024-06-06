part of 'body/employee_respond_body.dart';

List<Widget> _employeeRespondContainerWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  return [
    Text(
      key: KWidgetkeys.screen.employeeRespond.username,
      KMockText.userName,
      style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
      child: Text(
        key: KWidgetkeys.screen.employeeRespond.emailText,
        context.l10n.email,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    TextFieldWidget(
      widgetKey: KWidgetkeys.screen.employeeRespond.emailField,
      onChanged: (value) => context.read<EmployeeRespondBloc>().add(
            EmployeeRespondEvent.emailUpdated(value),
          ),
      hintText: context.l10n.emailHint,
      isDesk: isDesk,
      errorText: context.read<EmployeeRespondBloc>().state.formState ==
              EmployeeRespondEnum.invalidData
          ? context.read<EmployeeRespondBloc>().state.email.error.value(context)
          : null,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
      child: Text(
        key: KWidgetkeys.screen.employeeRespond.phoneNumberText,
        context.l10n.phoneNumber,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    TextFieldWidget(
      widgetKey: KWidgetkeys.screen.employeeRespond.phoneNumberField,
      onChanged: (value) => context.read<EmployeeRespondBloc>().add(
            EmployeeRespondEvent.phoneUpdated(value),
          ),
      hintText: context.l10n.phoneNumberHint,
      isDesk: isDesk,
      errorText: context.read<EmployeeRespondBloc>().state.formState ==
              EmployeeRespondEnum.invalidData
          ? context
              .read<EmployeeRespondBloc>()
              .state
              .phoneNumber
              .error
              .value(context)
          : null,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
      child: Text(
        key: KWidgetkeys.screen.employeeRespond.resume,
        context.l10n.resume,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    TextButton.icon(
      onPressed: context.read<EmployeeRespondBloc>().state.noResume
          ? null
          : () => context.read<EmployeeRespondBloc>().add(
                const EmployeeRespondEvent.loadResumeClicked(),
              ),
      style: KButtonStyles.borderButtonStyle,
      icon: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ).copyWith(
          left: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
        ),
        child: KIcon.attachFile,
      ),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          key: KWidgetkeys.screen.employeeRespond.upload,
          context.l10n.upload,
          style: isDesk
              ? AppTextStyle.text24.copyWith(
                  decoration: TextDecoration.underline,
                )
              : AppTextStyle.text16.copyWith(
                  decoration: TextDecoration.underline,
                ),
        ),
      ),
    ),
    if (isDesk) KSizedBox.kHeightSizedBox10 else KSizedBox.kHeightSizedBox8,
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize32,
            right: KPadding.kPaddingSize16,
          ),
          child: CheckPointWidget(
            key: KWidgetkeys.screen.employeeRespond.checkPoint,
            isCheck: context.read<EmployeeRespondBloc>().state.noResume,
            onChanged: () => context.read<EmployeeRespondBloc>().add(
                  const EmployeeRespondEvent.noResumeChanged(),
                ),
          ),
        ),
        Text(
          key: KWidgetkeys.screen.employeeRespond.noResume,
          context.l10n.noResume,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
      ],
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    if (isDesk)
      Row(
        children: [
          Expanded(
            child: sendButton(context: context, isDesk: true),
          ),
          KSizedBox.kWidthSizedBox73,
          Expanded(
            child: cancelButton(context: context, isDesk: true),
          ),
        ],
      )
    else ...[
      sendButton(context: context, isDesk: false),
      KSizedBox.kHeightSizedBox16,
      cancelButton(context: context, isDesk: false),
    ],
  ];
}

Widget cancelButton({required BuildContext context, required bool isDesk}) =>
    ButtonWidget(
      key: KWidgetkeys.screen.employeeRespond.cancel,
      text: context.l10n.cancel,
      onPressed: () => context.goNamedWithScroll(KRoute.workEmployee.name),
      isDesk: isDesk,
      backgroundColor: AppColors.materialThemeKeyColorsNeutral,
    );
Widget sendButton({required BuildContext context, required bool isDesk}) =>
    ButtonWidget(
      key: KWidgetkeys.screen.employeeRespond.send,
      text: context.l10n.send,
      onPressed: () => context.read<EmployeeRespondBloc>().add(
            const EmployeeRespondEvent.save(),
          ),
      isDesk: isDesk,
      backgroundColor: AppColors.materialThemeKeyColorsNeutralVariant,
    );
