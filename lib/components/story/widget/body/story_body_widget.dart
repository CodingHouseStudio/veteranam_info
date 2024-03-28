import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class StoryBodyWidget extends StatelessWidget {
  const StoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              key: KWidgetkeys.storyKeys.informationButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.information.path}',
              ),
              child: const Text('Information Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.storyKeys.discountsButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.discounts.path}',
              ),
              child: const Text('Discounts Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.storyKeys.workButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.work.path}',
              ),
              child: const Text('Work Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.storyKeys.profileButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.profile.path}',
              ),
              child: const Text('Profile Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.storyKeys.investorsButton,
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
