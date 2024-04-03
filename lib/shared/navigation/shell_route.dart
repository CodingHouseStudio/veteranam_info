import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.goRouterState,
    super.key,
  });
  final Widget navigationShell;
  final GoRouterState goRouterState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NawbarWidget(),
      body: navigationShell,
    );
  }
}
