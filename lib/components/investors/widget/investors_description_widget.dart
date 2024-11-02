import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsDescriptionWidget extends StatelessWidget {
  const InvestorsDescriptionWidget({Key? key, required this.isDesk})
      : super(key: key);
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: SectionWidget.get(
                isTablet: isDesk,
                // textPoint: null,
                title: context.l10n.supportOurVeterans,
                subtitle: context.l10n.investorsSubtitle,
                textButton: context.l10n.writeMessage,
                route: () => context.goNamed(KRoute.feedback.name),
                // prefixKey: null,
                titleKey: KWidgetkeys.screen.investors.feedbackTitle,
                subtitleKey: KWidgetkeys.screen.investors.feedbackSubtitle,
                buttonKey: KWidgetkeys.screen.investors.feedbackButton,
              ),
            ),
          ),
          ..._investorsImageWidgetList(
            isDesk: true,
          ),
        ],
      );
    } else if (Config.isWeb) {
      return Column(children: [
        ...SectionWidget.get(
          isTablet: isDesk,
          // textPoint: null,
          title: context.l10n.supportOurVeterans,
          subtitle: context.l10n.investorsSubtitle,
          textButton: context.l10n.writeMessage,
          route: () => context.goNamed(KRoute.feedback.name),
          // prefixKey: null,
          titleKey: KWidgetkeys.screen.investors.feedbackTitle,
          subtitleKey: KWidgetkeys.screen.investors.feedbackSubtitle,
          buttonKey: KWidgetkeys.screen.investors.feedbackButton,
        ),
        ..._investorsImageWidgetList(isDesk: false),
      ]);
    }
    return SizedBox.shrink();
  }
}

List<Widget> _investorsImageWidgetList({required bool isDesk}) {
  if (isDesk) {
    return [
      Column(
        key: KWidgetkeys.screen.investors.leftImages,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _leftImage(isDesk: isDesk),
      ),
      KSizedBox.kWidthSizedBox24,
      Column(
        key: KWidgetkeys.screen.investors.rightImages,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _rightImage(isDesk: isDesk),
      ),
    ];
  } else {
    return [
      Row(
        children: [
          Expanded(
            child: Column(
              key: KWidgetkeys.screen.investors.rightImages,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _leftImage(isDesk: isDesk),
            ),
          ),
          KSizedBox.kWidthSizedBox8,
          Expanded(
            child: Column(
              key: KWidgetkeys.screen.investors.leftImages,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _rightImage(isDesk: isDesk),
            ),
          ),
        ],
      ),
    ];
  }
}

List<Widget> _leftImage({required bool isDesk}) => [
      KImage.veteran1(),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      KImage.veteran2(),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      KImage.veteran3(),
    ];
List<Widget> _rightImage({required bool isDesk}) => [
      KImage.veteran4(),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      KImage.veteran5(),
    ];
