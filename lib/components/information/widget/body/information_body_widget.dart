import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class InformationBodyWidget extends StatelessWidget {
  const InformationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              key: KWidgetkeys.informationKeys.discountsButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.discounts.path}',
              ),
              child: const Text('Discounts Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.informationKeys.storyButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.story.path}',
              ),
              child: const Text('Story Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.informationKeys.workButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.work.path}',
              ),
              child: const Text('Work Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.informationKeys.profileButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.profile.path}',
              ),
              child: const Text('Profile Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.informationKeys.investorsButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.investors.path}',
              ),
              child: const Text('Investors Page'),
            ),
          ),
        ],
      ),
    );
  }
}
