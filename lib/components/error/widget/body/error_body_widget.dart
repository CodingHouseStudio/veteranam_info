import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class ErrorBodyWidget extends StatelessWidget {
  const ErrorBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        key: KWidgetkeys.errorKeys.button,
        onPressed: () => context.go(KRoute.home.path),
        child: const Text(KAppText.error),
      ),
    );
  }
}
