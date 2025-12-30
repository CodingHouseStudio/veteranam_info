import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class MockButtonWidget extends StatelessWidget {
  const MockButtonWidget({required this.onPressed, super.key});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        context.l10n.getMockData,
        style: AppTextStyle.text32,
      ),
    );
  }
}
