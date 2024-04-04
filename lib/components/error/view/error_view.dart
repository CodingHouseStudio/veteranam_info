import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/l10n/l10n.dart';
import 'package:kozak/shared/shared.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWidgetkeys.screen.error.screen,
      appBar: AppBar(
        title: Text(
          context.l10n.errorTitle,
          key: KWidgetkeys.screen.error.title,
        ),
      ),
      body: const ErrorBodyWidget(),
    );
  }
}
