import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class NameFieldWidget extends StatelessWidget {
  const NameFieldWidget({required this.changeName, super.key});
  final void Function(String text) changeName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          widgetKey: Key(''),
          onChanged: changeName,
          hintText: KAppText.nameTextFieldHint,
          fillColor: KColorTheme.white,
          enabledBorder: KBorder.outlineInput,
          focusedBorder: KBorder.outlineInput,
        ),
      ],
    );
  }
}
