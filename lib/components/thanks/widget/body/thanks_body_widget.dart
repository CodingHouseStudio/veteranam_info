import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class ThanksBodyWidget extends StatelessWidget {
  const ThanksBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KSizedBox.kHeightSizedBox30,
              Text(
                context.l10n.thankYou,
                style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
              ),
              KSizedBox.kHeightSizedBox8,
              Text(
                context.l10n.thankYouDescription,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox90
              else
                KSizedBox.kHeightSizedBox56,
              if (isDesk)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: KPadding.kPaddingSize128,
                        ),
                        child: BoxWidget(
                          text: context.l10n.myProfile,
                          isDesk: isDesk,
                          onTap: () => context.goNamed(KRoute.profile.name),
                        ),
                      ),
                    ),
                    KSizedBox.kWidthSizedBox48,
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: KPadding.kPaddingSize128,
                        ),
                        child: BoxWidget(
                          text: context.l10n.mainScreen,
                          isDesk: isDesk,
                          onTap: () => context.goNamed(KRoute.home.name),
                        ),
                      ),
                    ),
                  ],
                )
              else ...[
                _buildBoxWidgets(context, isDesk),
              ],
              if (isDesk)
                KSizedBox.kHeightSizedBox90
              else
                KSizedBox.kHeightSizedBox56,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBoxWidgets(BuildContext context, bool isDesk) {
    return Column(
      children: [
        BoxWidget(
          text: context.l10n.myProfile,
          isDesk: isDesk,
          onTap: () => context.goNamed(KRoute.profile.name),
        ),
        KSizedBox.kHeightSizedBox40,
        BoxWidget(
          text: context.l10n.mainScreen,
          isDesk: isDesk,
          onTap: () => context.goNamed(KRoute.home.name),
        ),
      ],
    );
  }
}
