import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class DropListFieldWidget extends StatelessWidget {
  const DropListFieldWidget({
    required this.onChanged,
    required this.labelText,
    required this.dropDownList,
    required this.isDesk,
    required this.textFieldKey,
    super.key,
    this.showErrorText,
    this.errorText,
    // this.initialValue,
    this.controller,
    this.focusNode,
    this.isButton,
    this.description,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<String> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  // final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Key textFieldKey;
  final bool? isButton;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return DropListFieldImplementationWidget<String>(
      labelText: labelText,
      isDesk: isDesk,
      controller: controller,
      errorText: errorText,
      onChanged: onChanged,
      showErrorText: showErrorText,
      isButton: isButton,
      items: (element) => Text(
        element,
        key: KWidgetkeys.widget.dropListField.itemText,
        style: AppTextStyle.materialThemeBodyLarge,
      ),
      focusNode: focusNode,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty || dropDownList.isEmpty) {
          return dropDownList;
        }

        return dropDownList
            .where(
              (element) => element.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
            )
            .toList();
      },
      // initialValue: initialValue,
      onSelectedItem: (String value) => value,
      onSelected: onChanged, textFieldKey: textFieldKey,
      description: description,
    );
  }
}

class DropListFieldImplementationWidget<T extends Object>
    extends StatefulWidget {
  const DropListFieldImplementationWidget({
    required this.labelText,
    required this.isDesk,
    required this.optionsBuilder,
    required this.items,
    required this.onChanged,
    required this.onSelected,
    required this.textFieldKey,
    this.onSelectedItem,
    super.key,
    this.showErrorText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.isButton,
    this.unfocusSufixIcon,
    // this.initialValue,
    this.suffixIconPadding,
    this.fieldParentWidget,
    this.errorMaxLines,
    this.description,
    this.lines,
    this.textStyle,
    this.unenabledList = const [],
    this.allElemts,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? isButton;
  final Widget Function(T element) items;
  final FutureOr<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  final Icon? unfocusSufixIcon;
  final void Function(T)? onSelected;
  final String Function(T value)? onSelectedItem;
  // final String? initialValue;
  final double? suffixIconPadding;
  final Widget Function({
    required Widget textField,
    required Widget suffixIcon,
  })? fieldParentWidget;
  final Key textFieldKey;
  final int? errorMaxLines;
  final String? description;
  final int? lines;
  final TextStyle? textStyle;
  final List<T>? unenabledList;
  final T? allElemts;

  @override
  State<DropListFieldImplementationWidget<T>> createState() =>
      _DropListFieldImplementationWidgetState();
}

class _DropListFieldImplementationWidgetState<T extends Object>
    extends State<DropListFieldImplementationWidget<T>> {
  late GlobalKey _anchorKey;
  late TextEditingController controller;
  late FocusNode focusNode;
  late bool showActiveIcon;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(_changeIcon);
    showActiveIcon = false;

    _anchorKey = GlobalKey(debugLabel: widget.labelText);
  }

  double get getWidth {
    final context = _anchorKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject()! as RenderBox;
      return box.hasSize ? box.size.width : double.infinity;
    }
    return double.infinity;
  }

  double get getHeight {
    final context = _anchorKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject()! as RenderBox;
      return box.hasSize ? box.size.height : 0;
    }
    return 0;
  }

  void _changeIcon() => setState(() {
        showActiveIcon = focusNode.hasFocus;
      });

  double get menuHeight =>
      widget.isDesk ? KMinMaxSize.maxHeight400 : KMinMaxSize.maxHeight220;

  OptionsViewOpenDirection get optionsViewOpenDirection {
    if (context.findRenderObject() == null) {
      return OptionsViewOpenDirection.down;
    }

    final renderBox = context.findRenderObject()! as RenderBox;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight =
        (screenHeight - (renderBox.localToGlobal(Offset.zero).dy + getHeight)) +
            (widget.isDesk ? KSize.kPixel70 : -KSize.kPixel20);
    return availableHeight > menuHeight
        ? OptionsViewOpenDirection.down
        : OptionsViewOpenDirection.up;
  }

  // @override
  // void didUpdateWidget(
  //   covariant DropListFieldImplementationWidget<T> oldWidget,
  // ) {
  //   if (widget.lines != null &&
  //       widget.controller != null &&
  //       widget.controller!.text.length < 30 &&
  //       (oldWidget.lines ?? 0) > widget.lines!) {
  //     final value = controller.text;
  //     controller
  //       ..text = '$value '
  //       ..text = value;
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      key: KWidgetkeys.widget.dropListField.widget,
      optionsBuilder: (textEditingValue) => widget.optionsBuilder(
        TextEditingValue(text: textEditingValue.text.trim()),
      ),
      focusNode: focusNode,
      textEditingController: controller,
      optionsViewOpenDirection: optionsViewOpenDirection,
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: optionsViewOpenDirection == OptionsViewOpenDirection.down
              ? Alignment.topLeft
              : Alignment.bottomLeft,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: menuHeight,
              maxWidth: getWidth,
            ),
            margin: const EdgeInsets.only(
              top: KPadding.kPaddingSize4,
              bottom: KPadding.kPaddingSize8,
            ),
            decoration: KWidgetTheme.boxDecorationCard,
            child: ListView.builder(
              key: KWidgetkeys.widget.dropListField.list,
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize16,
              ),
              prototypeItem: TextButton(
                onPressed: null,
                style: KButtonStyles.dropListButtonStyle,
                child: widget.items(options.elementAt(0)),
              ),
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return Padding(
                  padding: index == 0
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(top: KPadding.kPaddingSize8),
                  child: TextButton(
                    key: KWidgetkeys.widget.dropListField.item,
                    onPressed: widget.unenabledList == null ||
                            (widget.unenabledList != null &&
                                (widget.unenabledList!.isNotEmpty &&
                                    widget.unenabledList!.contains(option)))
                        ? null
                        : () {
                            focusNode.unfocus();
                            onSelected(option);
                          },
                    style: KButtonStyles.dropListButtonStyle,
                    child: widget.items(options.elementAt(index)),
                  ),
                );
              },
              // separatorBuilder: (context, index) => const Divider(),
              itemCount: options.length,
            ),
          ),
        );
      },
      // initialValue: TextEditingValue(text: widget.initialValue ?? ''),
      onSelected: widget.onSelected,
      displayStringForOption:
          widget.onSelectedItem ?? RawAutocomplete.defaultStringForOption,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        if (widget.fieldParentWidget != null) {
          final suffixHorizontalIconPadding =
              widget.suffixIconPadding ?? KPadding.kPaddingSize4;
          return InkWell(
            mouseCursor: widget.isButton ?? false
                ? SystemMouseCursors.click
                : SystemMouseCursors.text,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: () => focusNode.requestFocus(),
            child: widget.fieldParentWidget!(
              textField: _textField(
                showSuffixIcon: false,
                suffixHorizontalIconPadding: (suffixHorizontalIconPadding * 2) +
                    (widget.isDesk
                        ? KPadding.kPaddingSize4
                        : KPadding.kPaddingSize10),
                lines: widget.lines,
              ),
              suffixIcon: _suffixIcon,
            ),
          );
        }
        return _textField(showSuffixIcon: true);
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

  Widget _textField({
    required bool showSuffixIcon,
    double? suffixHorizontalIconPadding,
    int? lines,
  }) =>
      TextFieldWidget(
        key: _anchorKey, //KWidgetkeys.widget.dropListField.field,
        widgetKey: widget.textFieldKey,
        controller: controller, maxLines: lines, minLines: lines,
        focusNode: focusNode,
        suffixIcon: showSuffixIcon ? _suffixIcon : null,
        suffixIconPadding: suffixHorizontalIconPadding,
        onChanged: widget.onChanged,
        labelText: widget.labelText,
        showErrorText: widget.showErrorText,
        errorText: widget.errorText,
        disposeFocusNode: false,
        isDesk: widget.isDesk, textStyle: widget.textStyle,
        readOnly: widget.isButton,
        cursor: widget.isButton ?? false ? SystemMouseCursors.click : null,
        disabledBorder: KWidgetTheme.outlineInputBorderEnabled,
        borderHoverColor:
            showSuffixIcon ? AppColors.materialThemeRefNeutralNeutral40 : null,
        floatingLabelBehavior:
            showSuffixIcon ? null : FloatingLabelBehavior.always,
        errorMaxLines: widget.errorMaxLines, description: widget.description,
      );

  Widget get _suffixIcon => showActiveIcon
      ? IconButton(
          icon: KIcon.close.copyWith(
            key: KWidgetkeys.widget.dropListField.activeIcon,
          ),
          onPressed: focusNode.unfocus,
        )
      : (widget.unfocusSufixIcon ?? KIcon.trailing).copyWith(
          key: KWidgetkeys.widget.dropListField.icon,
        );

  @override
  void dispose() {
    focusNode.removeListener(_changeIcon);
    if (widget.controller == null) controller.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }
}
