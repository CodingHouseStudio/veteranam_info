import 'package:flutter/material.dart';
import 'package:veteranam/components/error/error.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
