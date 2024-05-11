import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DropListFieldWidget extends StatefulWidget {
  const DropListFieldWidget({
    required this.onChanged,
    required this.hintText,
    required this.dropDownList,
    required this.isDesk,
    super.key,
  });

  final void Function(String? text)? onChanged;
  final String hintText;
  final List<String> dropDownList;
  final bool isDesk;

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
      key: KWidgetkeys.widget.dropListField.widget,
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
          key: KWidgetkeys.widget.dropListField.list,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => TextButton(
            key: KWidgetkeys.widget.dropListField.item,
            onPressed: () => onSelected(options.elementAt(index)),
            style: KButtonStyles.whiteButtonStyle(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize32,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  options.elementAt(index),
                  key: KWidgetkeys.widget.dropListField.itemText,
                  style: AppTextStyle.text24,
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
          widgetKey: KWidgetkeys.widget.dropListField.field,
          controller: textEditingController,
          focusNode: focusNode,
          prefixIcon: isFocused
              ? KIcon.trailingUp
                  .setIconKey(KWidgetkeys.widget.dropListField.trailingUp)
              : KIcon.trailing.setIconKey(
                  KWidgetkeys.widget.dropListField.trailing,
                ),
          onChanged: widget.onChanged,
          hintText: widget.hintText,
          disposeFocusNode: false,
          isDesk: widget.isDesk,
        );
      },
    );
  }
}
