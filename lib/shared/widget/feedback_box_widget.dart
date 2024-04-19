import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class FeedbackBoxWidget extends StatelessWidget {
  const FeedbackBoxWidget({
    required this.isDesk,
    required this.sendAgain,
    required this.feedbackBoxKey,
    super.key,
  });
  final bool isDesk;
  final void Function() sendAgain;
  final GlobalKey feedbackBoxKey;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(feedbackBoxKey.currentContext!);
    });
    return isDesk
        ? IntrinsicHeight(
            key: KWidgetkeys.widget.feedbackBox.widget,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: KWidetTheme.boxDecorationWidget,
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.thankYou,
                          key: KWidgetkeys.widget.feedbackBox.title,
                          style: AppTextStyle.text96,
                        ),
                        KSizedBox.kHeightSizedBox32,
                        Text(
                          context.l10n.feedbackBoxSubtitle,
                          key: KWidgetkeys.widget.feedbackBox.subtitle,
                          style: AppTextStyle.text40,
                        ),
                        KSizedBox.kHeightSizedBox48,
                        ButtonWidget(
                          key: KWidgetkeys.widget.feedbackBox.button,
                          text: context.l10n.sendMore,
                          onPressed: sendAgain,
                          isDesk: true,
                        ),
                      ],
                    ),
                  ),
                ),
                KSizedBox.kWidthSizedBox24,
                Expanded(
                  child: Column(
                    children: [
                      BoxWidget(
                        text: context.l10n.information,
                        onTap: () => context.go(
                          '${KRoute.home.path}${KRoute.information.path}',
                        ),
                        isDesk: true,
                      ),
                      KSizedBox.kHeightSizedBox24,
                      BoxWidget(
                        text: context.l10n.investors,
                        onTap: () => context
                            .go('${KRoute.home.path}${KRoute.investors.path}'),
                        isDesk: true,
                      ),
                      KSizedBox.kHeightSizedBox24,
                      BoxWidget(
                        text: context.l10n.stories,
                        onTap: () => context
                            .go('${KRoute.home.path}${KRoute.story.path}'),
                        isDesk: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Column(
            key: KWidgetkeys.widget.feedbackBox.widget,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.thankYou,
                key: KWidgetkeys.widget.feedbackBox.title,
                style: AppTextStyle.text48,
              ),
              KSizedBox.kHeightSizedBox16,
              Text(
                context.l10n.feedbackBoxSubtitle,
                key: KWidgetkeys.widget.feedbackBox.subtitle,
                style: AppTextStyle.text24,
              ),
              KSizedBox.kHeightSizedBox24,
              ButtonWidget(
                key: KWidgetkeys.widget.feedbackBox.button,
                text: context.l10n.sendMore,
                onPressed: sendAgain,
                isDesk: false,
              ),
              KSizedBox.kHeightSizedBox24,
              BoxWidget(
                text: context.l10n.information,
                onTap: () =>
                    context.go('${KRoute.home.path}${KRoute.information.path}'),
                isDesk: false,
              ),
              KSizedBox.kHeightSizedBox24,
              BoxWidget(
                text: context.l10n.investors,
                onTap: () =>
                    context.go('${KRoute.home.path}${KRoute.investors.path}'),
                isDesk: false,
              ),
              KSizedBox.kHeightSizedBox24,
              BoxWidget(
                text: context.l10n.stories,
                onTap: () =>
                    context.go('${KRoute.home.path}${KRoute.story.path}'),
                isDesk: false,
              ),
            ],
          );
  }
}
