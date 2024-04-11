import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class BoxesWidget extends StatelessWidget {
  const BoxesWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDesk)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: HomeBoxWidget(
                  isDesk: isDesk,
                ),
              ),
              KSizedBox.kWidthSizedBox24,
              Expanded(
                child: buildTopBoxes(context: context, isDesk: isDesk),
              ),
            ],
          )
        else
          Column(
            children: [
              HomeBoxWidget(
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox16,
              buildTopBoxes(context: context, isDesk: isDesk),
              KSizedBox.kHeightSizedBox16,
            ],
          ),
        if (isDesk) KSizedBox.kHeightSizedBox24,
        if (isDesk)
          Row(
            children: [
              Expanded(
                child: BoxWidget(
                  text: context.l10n.information,
                  onIconTap: () => context.go(
                    '${KRoute.home.path}${KRoute.information.path}',
                  ),
                  isDesk: isDesk,
                ),
              ),
              KSizedBox.kWidthSizedBox24,
              Expanded(
                child: BoxWidget(
                  text: context.l10n.stories,
                  onIconTap: () =>
                      context.go('${KRoute.home.path}${KRoute.story.path}'),
                  isDesk: isDesk,
                ),
              ),
              KSizedBox.kWidthSizedBox24,
              Expanded(
                child: BoxWidget(
                  text: context.l10n.investors,
                  onIconTap: () => context.go(
                    '${KRoute.home.path}${KRoute.investors.path}',
                  ),
                  isDesk: isDesk,
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              KSizedBox.kHeightSizedBox16,
              BoxWidget(
                text: context.l10n.information,
                onIconTap: () => context.go(
                  '${KRoute.home.path}${KRoute.information.path}',
                ),
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox16,
              BoxWidget(
                text: context.l10n.stories,
                onIconTap: () =>
                    context.go('${KRoute.home.path}${KRoute.story.path}'),
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox16,
              BoxWidget(
                text: context.l10n.investors,
                onIconTap: () =>
                    context.go('${KRoute.home.path}${KRoute.investors.path}'),
                isDesk: isDesk,
              ),
            ],
          ),
      ],
    );
  }

  Widget buildTopBoxes({required bool isDesk, required BuildContext context}) {
    return Column(
      children: [
        BoxWidget(
          text: context.l10n.discountsCoupons,
          onIconTap: () =>
              context.go('${KRoute.home.path}${KRoute.discounts.path}'),
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox16,
        BoxWidget(
          text: context.l10n.work,
          onIconTap: () => context.go('${KRoute.home.path}${KRoute.work.path}'),
          isDesk: isDesk,
        ),
      ],
    );
  }
}
