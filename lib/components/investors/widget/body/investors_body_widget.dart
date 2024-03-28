import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              key: KWidgetkeys.investorsKeys.informationButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.information.path}',
              ),
              child: const Text('Information Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.investorsKeys.discountsButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.discounts.path}',
              ),
              child: const Text('Discounts Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.investorsKeys.storyButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.story.path}',
              ),
              child: const Text('Story Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.investorsKeys.workButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.work.path}',
              ),
              child: const Text('Work Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.investorsKeys.profileButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.profile.path}',
              ),
              child: const Text('Profile Page'),
            ),
          ),
        ],
      ),
    );
  }
}
