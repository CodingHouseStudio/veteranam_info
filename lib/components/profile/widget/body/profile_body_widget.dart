import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () => context.go(
              '${KRouteStatic.home.path}${KRouteStatic.information.path}',
            ),
            child: const Text('Infrmation Page'),
          ),
          TextButton(
            onPressed: () => context.go(
              '${KRouteStatic.home.path}${KRouteStatic.discounts.path}',
            ),
            child: const Text('Discounts Page'),
          ),
          TextButton(
            onPressed: () => context.go(
              '${KRouteStatic.home.path}${KRouteStatic.story.path}',
            ),
            child: const Text('Story Page'),
          ),
          TextButton(
            onPressed: () => context.go(
              '${KRouteStatic.home.path}${KRouteStatic.work.path}',
            ),
            child: const Text('Work Page'),
          ),
          TextButton(
            onPressed: () => context.go(
              '${KRouteStatic.home.path}${KRouteStatic.investors.path}',
            ),
            child: const Text('Investors Page'),
          ),
        ],
      ),
    );
  }
}
