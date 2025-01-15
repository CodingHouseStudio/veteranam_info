part of 'body/employer_body_widget.dart';

List<Widget> _textFieldWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ),
        child: Text(
          key: EmployerKeys.textPosition,
          context.l10n.position,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: EmployerKeys.fieldPosition,
        labelText: context.l10n.writeProposedPosition,
        onChanged: null,
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ),
        child: Text(
          key: EmployerKeys.textWage,
          context.l10n.wage,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: EmployerKeys.fieldWage,
        labelText: context.l10n.writeTheWage,
        onChanged: null,
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ),
        child: Text(
          key: EmployerKeys.textCity,
          context.l10n.selectCityOfWork,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      DropListFieldWidget(
        textFieldKey: EmployerKeys.fieldCity,
        onChanged: null,
        labelText: context.l10n.selectCity,
        dropDownList: KMockText.dropDownList,
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
        child: Row(
          spacing: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize10,
          children: [
            SwitchWidgetWithoutBloc(
              key: EmployerKeys.switchWidget,
            ),
            Text(
              key: EmployerKeys.textSwitchWidget,
              context.l10n.remotely,
              style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
            ),
          ],
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ),
        child: Text(
          key: EmployerKeys.textContact,
          '${context.l10n.contacts}*',
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: EmployerKeys.fieldContact,
        labelText: context.l10n.howToContactYou,
        onChanged: null,
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    ];
