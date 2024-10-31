import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MarkdownDialogTitleWidget extends StatelessWidget {
  const MarkdownDialogTitleWidget({
    required this.title,
    required this.isTablet,
    super.key,
  });
  final String title;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: isTablet
                  ? AppTextStyle.materialThemeHeadlineMediumBold
                  : AppTextStyle.materialThemeTitleLargeBold,
            ),
          ),
          KSizedBox.kWidthSizedBox16,
          _cancelButton(context),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _cancelButton(context),
          KSizedBox.kHeightSizedBox8,
          Text(
            title,
            style: isTablet
                ? AppTextStyle.materialThemeHeadlineMediumBold
                : AppTextStyle.materialThemeTitleLargeBold,
          ),
        ],
      );
    }
  }

  Widget _cancelButton(BuildContext context) => CancelWidget(
        widgetKey: KWidgetkeys.screen.privacyPolicy.closeIcon,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            if (Config.isBusiness) {
              context.goNamed(KRoute.discountsAdd.name);
            } else {
              context.goNamed(KRoute.home.name);
            }
          }
        },
      );
}
