import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class DropListFieldWidget extends StatelessWidget {
  const DropListFieldWidget({
    required this.onChanged,
    required this.labelText,
    required this.dropDownList,
    required this.isDesk,
    super.key,
    this.showErrorText,
    this.errorText,
    this.controller,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<String> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      key: KWidgetkeys.widget.dropListField.widget,
      controller: controller,
      label: Text(
        labelText,
        key: KWidgetkeys.widget.dropListField.field,
      ),
      requestFocusOnTap: true,
      trailingIcon: KIcon.trailing.copyWith(
        key: KWidgetkeys.widget.dropListField.trailing,
      ),
      selectedTrailingIcon: KIcon.close.copyWith(
        key: KWidgetkeys.widget.dropListField.closeIcon,
      ),
      onSelected: (value) => onChanged?.call(value ?? ''),
      dropdownMenuEntries: List.generate(
        dropDownList.length,
        (int index) => DropdownMenuEntry<String>(
          // key: KWidgetkeys.widget.dropListField.item,
          value: dropDownList.elementAt(index),
          label: dropDownList.elementAt(index),
          style: KButtonStyles.dropFieldButtonStyle,
        ),
      ),
      menuHeight: KMinMaxSize.maxHeight220,
      menuStyle: KWidgetTheme.dropTextMenuStyle,
      expandedInsets: EdgeInsets.zero,
      inputDecorationTheme: KWidgetTheme.inputDecorationTheme,
      errorText: showErrorText ?? true ? errorText : null,
    );
    // return Autocomplete<String>(
    //   key: KWidgetkeys.widget.dropListField.widget,
    //   optionsBuilder: (TextEditingValue textEditingValue) {
    //     if (textEditingValue.text.isEmpty) {
    //       return widget.dropDownList;
    //     }

    //     return widget.dropDownList
    //         .where(
    //           (element) => element.toLowerCase().contains(
    //                 textEditingValue.text.toLowerCase(),
    //               ),
    //         )
    //         .toList();
    //   },
    //   optionsViewBuilder: (context, onSelected, options) {
    //     return Align(
    //       alignment: Alignment.topLeft,
    //       child: Container(
    //         constraints: BoxConstraints(
    //           maxHeight: widget.isDesk
    //               ? KMinMaxSize.maxHeight400
    //               : KMinMaxSize.maxHeight220,
    //         ),
    //         decoration: KWidgetTheme.boxDecorationCard,
    //         clipBehavior: Clip.hardEdge,
    //         child: ListView.builder(
    //           shrinkWrap: true,
    //           key: KWidgetkeys.widget.dropListField.list,
    //           // padding: EdgeInsets.only(
    //           //   right: (widget.isDesk
    //           //           ? KPadding.kPaddingSize90
    //           //           : KPadding.kPaddingSize16) *
    //           //       2,
    //           // ),
    //           itemBuilder: (context, index) => TextButton(
    //             key: KWidgetkeys.widget.dropListField.item,
    //             onPressed: () => onSelected(options.elementAt(index)),
    //             style: KButtonStyles.dropListButtonStyle,
    //             child: Text(
    //               options.elementAt(index),
    //               key: KWidgetkeys.widget.dropListField.itemText,
    //               style: AppTextStyle.materialThemeBodyLarge,
    //             ),
    //           ),
    //           // separatorBuilder: (context, index) => const Divider(),
    //           itemCount: options.length,
    //         ),
    //       ),
    //     );
    //   },
    //   fieldViewBuilder:
    //       (context, textEditingController, focusNode, onFieldSubmitted) {
    //     focusNode
    //         .addListener(() => setState(() => isFocused = focusNode.hasFocus
    // ));
    //     return TextFieldWidget(
    //       widgetKey: KWidgetkeys.widget.dropListField.field,
    //       controller: textEditingController,
    //       focusNode: focusNode,
    //       suffixIcon: isFocused
    //           ? IconButton(
    //               icon: KIcon.close.copyWith(
    //                 key: KWidgetkeys.widget.dropListField.trailingUp,
    //               ),
    //               onPressed: focusNode.unfocus,
    //             )
    //           : KIcon.trailing.copyWith(
    //               key: KWidgetkeys.widget.dropListField.trailing,
    //             ),
    //       onChanged: widget.onChanged,
    //       hintText: widget.hintText,
    //       disposeFocusNode: false,
    //       isDesk: widget.isDesk,
    //     );
    //   },
    // );
  }
}
