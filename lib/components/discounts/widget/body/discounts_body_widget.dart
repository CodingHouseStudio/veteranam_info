import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class DiscountsBodyWidget extends StatelessWidget {
  const DiscountsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              key: KWidgetkeys.discountsKeys.informationButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.information.path}',
              ),
              child: const Text('Information Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.discountsKeys.storyButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.story.path}',
              ),
              child: const Text('Story Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.discountsKeys.workButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.work.path}',
              ),
              child: const Text('Work Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.discountsKeys.profileButton,
              onPressed: () => context.go(
                '${KRoute.home.path}${KRoute.profile.path}',
              ),
              child: const Text('Profile Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWidgetkeys.discountsKeys.investorsButton,
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
