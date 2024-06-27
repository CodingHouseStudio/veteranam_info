import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class TextFieldAdditionalWidget extends StatelessWidget {
  const TextFieldAdditionalWidget({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidgetTheme.textFieldDecoration,
      constraints: const BoxConstraints(minWidth: KMinMaxSize.maxWidth328),
      padding: const EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize32,
        vertical: KPadding.kPaddingSize16,
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: context.l10n.text),
            controller: controller,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ],
      ),
    );
  }
}
