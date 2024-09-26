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
    return DropListFieldImplementationWidget(
      labelText: labelText,
      dropDownList: dropDownList,
      isDesk: isDesk,
      controller: controller,
      errorText: errorText,
      onChanged: onChanged,
      showErrorText: showErrorText,
      searchCallback: (entries, query) {
        onChanged?.call(query);
        final index = entries.indexWhere(
          (entry) => entry.label.toLowerCase().contains(query.toLowerCase()),
        );
        return index == -1 ? null : index;
      },
    );
  }
}

class DropListFieldImplementationWidget extends StatefulWidget {
  const DropListFieldImplementationWidget({
    required this.labelText,
    required this.dropDownList,
    required this.isDesk,
    super.key,
    this.onChanged,
    this.showErrorText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.elementList,
    this.enabled,
    this.searchCallback,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<String> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<Widget>? elementList;
  final bool? enabled;
  final int? Function(List<DropdownMenuEntry<String>>, String)? searchCallback;

  @override
  State<DropListFieldImplementationWidget> createState() =>
      _DropListFieldImplementationWidgetState();
}

class _DropListFieldImplementationWidgetState
    extends State<DropListFieldImplementationWidget> {
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
      initialValue: TextEditingValue.empty,
      optionsMaxHeight:
          widget.isDesk ? KMinMaxSize.maxHeight400 : KMinMaxSize.maxHeight220,
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: widget.isDesk
                  ? KMinMaxSize.maxHeight400
                  : KMinMaxSize.maxHeight220,
            ),
            decoration: KWidgetTheme.boxDecorationCard,
            clipBehavior: Clip.hardEdge,
            child: ListView.builder(
              shrinkWrap: true,
              key: KWidgetkeys.widget.dropListField.list,
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize16,
                // right: (widget.isDesk
                //         ? KPadding.kPaddingSize90
                //         : KPadding.kPaddingSize16) *
                //     2,
              ),
              itemBuilder: (context, index) => TextButton(
                key: KWidgetkeys.widget.dropListField.item,
                onPressed: () => onSelected(options.elementAt(index)),
                style: KButtonStyles.dropListButtonStyle,
                child: Text(
                  options.elementAt(index),
                  key: KWidgetkeys.widget.dropListField.itemText,
                  style: AppTextStyle.materialThemeBodyLarge,
                ),
              ),
              // separatorBuilder: (context, index) => const Divider(),
              itemCount: options.length,
            ),
          ),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        focusNode
            .addListener(() => setState(() => isFocused = focusNode.hasFocus));
        return TextFieldWidget(
          widgetKey: KWidgetkeys.widget.dropListField.field,
          controller: textEditingController,
          focusNode: focusNode,
          suffixIcon: isFocused
              ? IconButton(
                  icon: KIcon.close.copyWith(
                    key: KWidgetkeys.widget.dropListField.closeIcon,
                  ),
                  onPressed: focusNode.unfocus,
                )
              : KIcon.trailing.copyWith(
                  key: KWidgetkeys.widget.dropListField.trailing,
                ),
          onChanged: widget.onChanged,
          labelText: widget.labelText,
          disposeFocusNode: false,
          isDesk: widget.isDesk,
        );
      },
    );
    // return DropdownMenu<String>(
    //   key: KWidgetkeys.widget.dropListField.widget,
    //   controller: controller,
    //   label: Text(
    //     labelText,
    //     key: KWidgetkeys.widget.dropListField.field,
    //   ),
    //   enableFilter: true,
    //   requestFocusOnTap: true,
    //   searchCallback: searchCallback,
    //   trailingIcon: _getElementWidget(
    //     KIcon.trailing.copyWith(
    //       key: KWidgetkeys.widget.dropListField.trailing,
    //     ),
    //   ),
    //   selectedTrailingIcon: KIcon.close.copyWith(
    //     key: KWidgetkeys.widget.dropListField.closeIcon,
    //   ),
    //   onSelected: (value) => onChanged?.call(value ?? ''),
    //   enabled: enabled ?? true,
    //   dropdownMenuEntries: List.generate(
    //     dropDownList.length,
    //     (int index) => DropdownMenuEntry<String>(
    //       // key: KWidgetkeys.widget.dropListField.item,
    //       value: dropDownList.elementAt(index),
    //       label: dropDownList.elementAt(index),
    //       style: KButtonStyles.dropFieldButtonStyle,
    //     ),
    //   ),
    //   menuHeight: KMinMaxSize.maxHeight220,
    //   menuStyle: KWidgetTheme.dropTextMenuStyle,
    //   expandedInsets: EdgeInsets.zero,
    //   inputDecorationTheme: KWidgetTheme.inputDecorationTheme.copyWith(
    //     contentPadding: (isDesk
    //         ? const EdgeInsets.symmetric(
    //             horizontal: KPadding.kPaddingSize32,
    //             vertical: KPadding.kPaddingSize16,
    //           )
    //         : const EdgeInsets.all(KPadding.kPaddingSize16)),
    //     floatingLabelBehavior: (elementList?.isEmpty ?? true)
    //         ? null
    //         : FloatingLabelBehavior.always,
    //   ),
    //   errorText: showErrorText ?? true ? errorText : null,
    //   focusNode: focusNode,
    // );
  }

  Widget _getElementWidget(Icon icon) =>
      widget.elementList != null && widget.elementList!.isNotEmpty
          ? Row(
              children: [
                // const Spacer(),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.elementList!,
                      ),
                    ),
                  ),
                ),
                icon,
              ],
            )
          : icon;
}
