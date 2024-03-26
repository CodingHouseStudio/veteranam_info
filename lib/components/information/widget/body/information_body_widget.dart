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
              key: KWIdgetkeys.informationKeys.discountsButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.discounts.path}',
              ),
              child: const Text('Discounts Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.informationKeys.storyButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.story.path}',
              ),
              child: const Text('Story Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.informationKeys.workButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.work.path}',
              ),
              child: const Text('Work Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.informationKeys.profileButton,
              onPressed: () => context.go(
                '${KRouteStatic.home.path}${KRouteStatic.profile.path}',
              ),
              child: const Text('Profile Page'),
            ),
          ),
          Expanded(
            child: TextButton(
              key: KWIdgetkeys.informationKeys.investorsButton,
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
