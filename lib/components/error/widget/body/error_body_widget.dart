import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/l10n/l10n.dart';
import 'package:kozak/shared/shared.dart';

class ErrorBodyWidget extends StatelessWidget {
  const ErrorBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        key: KWidgetkeys.screen.error.button,
        onPressed: () => context.go(KRoute.home.path),
        child: Text(context.l10n.errorMessage),
      ),
    );
  }
}
