import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DropListFieldWidget extends StatefulWidget {
  const DropListFieldWidget({
    required this.onChanged,
    required this.hintText,
    required this.dropDownList,
    super.key,
  });

  final void Function(String? text) onChanged;
  final String hintText;
  final List<String> dropDownList;

  @override
  State<DropListFieldWidget> createState() => _DropListFieldWidgetState();
}

class _DropListFieldWidgetState extends State<DropListFieldWidget> {
  late bool isFocused;
  @override
  void initState() {
    isFocused = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return widget.dropDownList;
        }

        return widget.dropDownList
            .where(
              (element) => element.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
            )
            .toList();
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });
        return TextFieldWidget(
          widgetKey: KWidgetkeys.dropListField.field,
          controller: textEditingController,
          focusNode: focusNode,
          prefixIcon: isFocused ? KIcon.trailingUp : KIcon.trailing,
          onChanged: widget.onChanged,
          hintText: widget.hintText,
        );
      },
    );
  }
}
