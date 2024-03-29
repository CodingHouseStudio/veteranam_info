import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
  late TextEditingController controller;
  late FocusNode focusNode;
  bool isFocused = false;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<String>(
          key: KWidgetkeys.dropListField.widget,
          controller: controller,
          focusNode: focusNode,
          builder: (
            context,
            controller,
            focusNode,
          ) =>
              TextFieldWidget(
            widgetKey: KWidgetkeys.dropListField.field,
            controller: controller,
            focusNode: focusNode,
            prefixIcon: isFocused ? KIcon.trailingUp : KIcon.trailing,
            onChanged: widget.onChanged,
            hintText: widget.hintText,
          ),
          itemBuilder: (BuildContext context, String value) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSizeML,
            ),
            child: Text(
              value,
              style: KAppTextStyle.lableMedium,
              key: KWidgetkeys.dropListField.items,
            ),
          ),
          onSelected: (String value) => setState(() {
            controller.text = value;
          }),
          suggestionsCallback: (String search) => widget.dropDownList
              .where(
                (element) => element.toLowerCase().startsWith(
                      search.toLowerCase(),
                    ),
              )
              .toList(),
          itemSeparatorBuilder: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}
