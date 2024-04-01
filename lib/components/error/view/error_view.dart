import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWidgetkeys.errorKeys.screen,
      appBar: AppBar(
        title: Text(
          KAppText.errorTitle,
          key: KWidgetkeys.errorKeys.title,
        ),
      ),
      body: const ErrorBodyWidget(),
    );
  }
}
