import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const FilterBoxWidget(
            filters: ['Пільги', 'Житло', 'Гарячі лінії'],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextButton(
                  key: KWidgetkeys.homeKeys.informationButton,
                  onPressed: () => context.go(
                    '${KRoute.home.path}${KRoute.information.path}',
                  ),
                  child: const Text('Information Page'),
                ),
              ),
              Expanded(
                child: TextButton(
                  key: KWidgetkeys.homeKeys.discountsButton,
                  onPressed: () => context.go(
                    '${KRoute.home.path}${KRoute.discounts.path}',
                  ),
                  child: const Text('Discounts Page'),
                ),
              ),
              Expanded(
                child: TextButton(
                  key: KWidgetkeys.homeKeys.storyButton,
                  onPressed: () => context.go(
                    '${KRoute.home.path}${KRoute.story.path}',
                  ),
                  child: const Text('Story Page'),
                ),
              ),
              Expanded(
                child: TextButton(
                  key: KWidgetkeys.homeKeys.workButton,
                  onPressed: () => context.go(
                    '${KRoute.home.path}${KRoute.work.path}',
                  ),
                  child: const Text('Work Page'),
                ),
              ),
              Expanded(
                child: TextButton(
                  key: KWidgetkeys.homeKeys.profileButton,
                  onPressed: () => context.go(
                    '${KRoute.home.path}${KRoute.profile.path}',
                  ),
                  child: const Text('Profile Page'),
                ),
              ),
              Expanded(
                child: TextButton(
                  key: KWidgetkeys.homeKeys.investorsButton,
                  onPressed: () => context.go(
                    '${KRoute.home.path}${KRoute.investors.path}',
                  ),
                  child: const Text('Investors Page'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
