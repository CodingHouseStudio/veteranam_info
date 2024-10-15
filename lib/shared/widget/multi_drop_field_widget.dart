import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veteranam/shared/shared.dart';

class MultiDropFieldWidget extends StatelessWidget {
  const MultiDropFieldWidget({
    required this.labelText,
    required this.dropDownList,
    required this.isDesk,
    required this.removeEvent,
    required this.textFieldKey,
    required this.values,
    super.key,
    this.onChanged,
    this.showErrorText,
    this.errorText,
    // this.controller,
    this.errorMaxLines,
    this.isButton,
    this.description,
    this.allElemts,
    this.isRequired,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<String> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  // final TextEditingController? controller;
  final List<String>? values;
  final void Function(String value)? removeEvent;
  final Key textFieldKey;
  final int? errorMaxLines;
  final bool? isButton;
  final String? description;
  final String? allElemts;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return MultiDropFieldImplementationWidget<String>(
      textFieldKey: textFieldKey,
      onChanged: onChanged,
      labelText: labelText,
      dropDownList: dropDownList,
      allElemts: allElemts,
      isDesk: isDesk,
      isRequired: isRequired,
      values: values,
      // controller: controller,
      removeEvent: removeEvent,
      showErrorText: showErrorText,
      errorText: errorText,
      getItemText: null,
      isButton: isButton,
      errorMaxLines: errorMaxLines,
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
      item: (element) => Text(
        element,
        key: KWidgetkeys.widget.dropListField.itemText,
        style: AppTextStyle.materialThemeBodyLarge,
      ),
      description: description,
    );
  }
}

class MultiDropFieldImplementationWidget<T extends Object>
    extends StatefulWidget {
  const MultiDropFieldImplementationWidget({
    required this.onChanged,
    required this.labelText,
    required this.dropDownList,
    required this.isDesk,
    required this.values,
    required this.removeEvent,
    required this.showErrorText,
    required this.errorText,
    required this.item,
    required this.optionsBuilder,
    required this.getItemText,
    required this.textFieldKey,
    this.isRequired,
    // this.controller,
    super.key,
    this.tralingList,
    this.isButton,
    this.unfocusSufixIcon,
    this.textFieldChangeEvent,
    this.suffixIconPadding,
    this.focusNode,
    this.errorMaxLines,
    this.description,
    this.allElemts,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<T> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  final List<String>? values;
  final void Function(String value)? removeEvent;
  // final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<Widget>? tralingList;
  final bool? isButton;
  final Widget Function(T element) item;
  final FutureOr<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  final Icon? unfocusSufixIcon;
  final String Function(T value)? getItemText;
  final void Function({
    required TextEditingController controller,
    required FocusNode focusNode,
  })? textFieldChangeEvent;
  final double? suffixIconPadding;
  final Key textFieldKey;
  final int? errorMaxLines;
  final String? description;
  final T? allElemts;
  final bool? isRequired;

  @override
  State<MultiDropFieldImplementationWidget<T>> createState() =>
      _MultiDropFieldImplementationWidgetState<T>();
}

class _MultiDropFieldImplementationWidgetState<T extends Object>
    extends State<MultiDropFieldImplementationWidget<T>> {
  late TextEditingController controller;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    controller = TextEditingController();
    focusNode = (widget.focusNode ?? FocusNode())
      ..onKeyEvent = _handleKeyEvent
      ..addListener(_unFocusData);
  }

  void _unFocusData() {
    if (!focusNode.hasFocus && controller.text.isNotEmpty) {
      widget.onChanged?.call(controller.text);
      controller.clear();
    }
  }

  KeyEventResult _handleKeyEvent(
    FocusNode node,
    KeyEvent keyEvent,
  ) {
    if (controller.text.trim().isNotEmpty &&
        keyEvent is KeyDownEvent &&
        keyEvent.logicalKey == LogicalKeyboardKey.enter) {
      widget.onChanged?.call(controller.text);
      focusNode.unfocus();
      controller.clear();
      // setState(() {
      //   changeFieldValue = !changeFieldValue;
      // });

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  bool get selectedValueIsNotEmpty {
    if (widget.values == null && widget.allElemts != null) return true;
    if (widget.values != null && widget.values!.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropListFieldImplementationWidget<T>(
          isRequired: widget.isRequired,
          textFieldKey: widget.textFieldKey,
          labelText: widget.labelText,
          isDesk: widget.isDesk,
          controller: controller,
          errorText: widget.errorText,
          onChanged: null,
          focusNode: focusNode,
          showErrorText: widget.showErrorText,
          optionsBuilder: widget.optionsBuilder,
          unfocusSufixIcon: widget.unfocusSufixIcon,
          isButton: widget.isButton,
          items: widget.item,
          errorMaxLines: widget.errorMaxLines,
          description: widget.description,
          unenabledList: widget.values == null
              ? null
              : widget.dropDownList
                  .where(
                    (element) => widget.values!.any(
                      (value) => (getItemText(element)) == value,
                    ),
                  )
                  .toList(),
          onSelected: (value) {
            widget.onChanged?.call(getItemText(value));
            controller.clear();
            focusNode.unfocus();
          },
          isLoading: widget.dropDownList.isEmpty,
        ),
        if (selectedValueIsNotEmpty) ...[
          KSizedBox.kHeightSizedBox8,
          Wrap(
            spacing: KPadding.kPaddingSize8,
            runSpacing: KPadding.kPaddingSize8,
            children: List.generate(
              widget.values?.length ?? (widget.allElemts != null ? 1 : 0),
              (index) => CancelChipWidget(
                widgetKey: KWidgetkeys.widget.multiDropField.chips,
                isDesk: widget.isDesk,
                labelText: getValue(index),
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize8,
                  vertical: KPadding.kPaddingSize4,
                ),
                textStyle: widget.isDesk
                    ? AppTextStyle.materialThemeTitleMedium
                    : AppTextStyle.materialThemeTitleSmall,
                onPressed: () => widget.removeEvent?.call(
                  getValue(index),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String getValue(int index) => widget.values == null
      ? getItemText(widget.allElemts!)
      : widget.values!.elementAt(index);

  String getItemText(T value) =>
      widget.getItemText?.call(value) ?? value.toString();

  @override
  void dispose() {
    focusNode.removeListener(_unFocusData);
    controller
        // if (widget.controller == null)
        .dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }
}
