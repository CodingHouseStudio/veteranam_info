import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.homeKeys.informationButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.information.path}',
              ),
              child: const Text('Information Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.homeKeys.discountsButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.discounts.path}',
              ),
              child: const Text('Discounts Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.homeKeys.storyButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.story.path}',
              ),
              child: const Text('Story Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.homeKeys.workButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.work.path}',
              ),
              child: const Text('Work Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.homeKeys.profileButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.profile.path}',
              ),
              child: const Text('Profile Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.homeKeys.investorsButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.investors.path}',
              ),
              child: const Text('Investors Page'),
            ),
          ),
        ],
      ),
    );
  }
}
