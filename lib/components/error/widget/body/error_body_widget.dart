import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class ErrorBodyWidget extends StatelessWidget {
  const ErrorBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        key: KWidgetkeys.screen.error.button,
        onPressed: () => context.goNamed(KRoute.home.name),
        child: Text(context.l10n.errorMessage),
      ),
    );
  }
}
