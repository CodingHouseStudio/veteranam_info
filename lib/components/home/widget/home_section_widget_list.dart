part of 'body/home_body_widget.dart';

List<Widget> getDiscountSection({
  required BuildContext context,
  required bool isTablet,
}) =>
    SectionWidget.get(
      buttonKey: KWidgetkeys.screen.home.discountButton,
      prefixKey: KWidgetkeys.screen.home.discountPrefix,
      titleKey: KWidgetkeys.screen.home.discountTitle,
      subtitleKey: KWidgetkeys.screen.home.discountSubtitle,
      textPoint: context.l10n.saveMoney,
      title: context.l10n.discountsServices,
      subtitle: context.l10n.discountsServicesSubtitle,
      textButton: context.l10n.toDiscount,
      route: () => context.goNamed(KRoute.discounts.name),
      bottomWidget: KSizedBox.kHeightSizedBox90,
      isTablet: isTablet,
    );
List<Widget> getInformationSection({
  required BuildContext context,
  required bool isTablet,
}) =>
    SectionWidget.get(
      buttonKey: KWidgetkeys.screen.home.informationButton,
      prefixKey: KWidgetkeys.screen.home.informationPrefix,
      subtitleKey: KWidgetkeys.screen.home.informationSubtitle,
      titleKey: KWidgetkeys.screen.home.informationTitle,
      textPoint: context.l10n.findOut,
      title: context.l10n.informationNews,
      subtitle: context.l10n.informationNewsSubtitle,
      textButton: context.l10n.toInfomation,
      route: () => context.goNamed(KRoute.information.name),
      bottomWidget: KSizedBox.kHeightSizedBox48,
      isTablet: isTablet,
    );

List<Widget> getFAQSection({
  required BuildContext context,
  required bool isDesk,
}) =>
    [
      TextPointWidget(
        context.l10n.whatYouMostInterestedIn,
        key: KWidgetkeys.screen.home.faqPrefix,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
      Text(
        context.l10n.answersYourQuestions,
        key: KWidgetkeys.screen.home.faqTitle,
        style: isDesk
            ? AppTextStyle.materialThemeDisplayLarge
            : AppTextStyle.materialThemeDisplaySmall,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox16 else KSizedBox.kHeightSizedBox8,
      Text(
        context.l10n.questionSubtitle,
        key: KWidgetkeys.screen.home.faqSubtitle,
        style: isDesk
            ? AppTextStyle.materialThemeBodyLarge
            : AppTextStyle.materialThemeBodyMedium,
      ),
      KSizedBox.kHeightSizedBox16,
      DoubleButtonWidget(
        widgetKey: KWidgetkeys.screen.home.faqButton,
        text: context.l10n.writeMessage,
        onPressed: () => context.goNamed(KRoute.feedback.name),
        isDesk: isDesk,
      ),
    ];
