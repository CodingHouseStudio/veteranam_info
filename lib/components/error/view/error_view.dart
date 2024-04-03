import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWidgetkeys.errorScreenKeys.screen,
      appBar: AppBar(
        title: Text(
          KAppText.errorTitle,
          key: KWidgetkeys.errorScreenKeys.title,
        ),
      ),
      body: const ErrorBodyWidget(),
    );
  }
}
