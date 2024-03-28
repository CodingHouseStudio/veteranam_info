import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class WorkBodyWidget extends StatelessWidget {
  const WorkBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              key: KWidgetkeys.workKeys.informationButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.information.path}',
              ),
              child: const Text('Information Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.workKeys.discountsButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.discounts.path}',
              ),
              child: const Text('Discounts Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.workKeys.storyButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.story.path}',
              ),
              child: const Text('Story Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.workKeys.profileButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.profile.path}',
              ),
              child: const Text('Profile Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.workKeys.investorsButton,
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
