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
      key: KWidgetkeys.widgetKeys.dropListFieldKeys.widget,
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
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
          key: KWidgetkeys.widgetKeys.dropListFieldKeys.list,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => TextButton(
            key: KWidgetkeys.widgetKeys.dropListFieldKeys.items,
            onPressed: () => onSelected(options.elementAt(index)),
            style: KButtonStyles.whiteButtonStyle.copyWith(
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSizeML,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  options.elementAt(index),
                  style: AppTextStyle.lableM,
                ),
              ),
            ),
          ),
          // separatorBuilder: (context, index) => const Divider(),
          itemCount: options.length,
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });
        return TextFieldWidget(
          widgetKey: KWidgetkeys.widgetKeys.dropListFieldKeys.field,
          controller: textEditingController,
          focusNode: focusNode,
          prefixIcon: isFocused ? KIcon.trailingUp : KIcon.trailing,
          onChanged: widget.onChanged,
          hintText: widget.hintText,
          disposeFocusNode: false,
        );
      },
    );
  }
}
