import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({required this.onChange, super.key});
  final void Function(String text) onChange;
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      widgetKey: KWidgetkeys.searchKeys.field,
      prefixIcon: KIcon.search,
      textAlign: TextAlign.left,
      onChanged: onChange,
      hintText: KAppText.searchTextFieldHint,
      fillColor: KColorTheme.white,
      enabledBorder: KBorder.outlineInput,
      focusedBorder: KBorder.outlineInput,
    );
  }
}
