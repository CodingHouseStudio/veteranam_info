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
          key: KWidgetkeys.screen.employer.textPosition,
          context.l10n.position,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: KWidgetkeys.screen.employer.fieldPosition,
        hintText: context.l10n.writeProposedPosition,
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
          key: KWidgetkeys.screen.employer.textWage,
          context.l10n.wage,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: KWidgetkeys.screen.employer.fieldWage,
        hintText: context.l10n.writeTheWage,
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
          key: KWidgetkeys.screen.employer.textCity,
          context.l10n.selectCityOfWork,
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      DropListFieldWidget(
        textFieldKey: KWidgetkeys.screen.employer.fieldCity,
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
          children: [
            SwitchWidgetWithoutBloc(
              key: KWidgetkeys.screen.employer.switchWidget,
            ),
            Padding(
              padding: EdgeInsets.only(
                left:
                    isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize10,
              ),
              child: Text(
                key: KWidgetkeys.screen.employer.textSwitchWidget,
                context.l10n.remotely,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
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
          key: KWidgetkeys.screen.employer.textContact,
          '${context.l10n.contacts}*',
          style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
      ),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      TextFieldWidget(
        widgetKey: KWidgetkeys.screen.employer.fieldContact,
        hintText: context.l10n.howToContactYou,
        onChanged: null,
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    ];
