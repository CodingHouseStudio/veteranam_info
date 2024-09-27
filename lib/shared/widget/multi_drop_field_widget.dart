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
    super.key,
    this.onChanged,
    this.showErrorText,
    this.errorText,
    this.values,
    this.controller,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<String> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  final TextEditingController? controller;
  final List<String>? values;
  final void Function(String value) removeEvent;
  final Key textFieldKey;

  @override
  Widget build(BuildContext context) {
    return MultiDropFieldImplementationWidget<String>(
      textFieldKey: textFieldKey,
      onChanged: onChanged,
      labelText: labelText,
      dropDownList: dropDownList,
      isDesk: isDesk,
      values: values,
      controller: controller,
      removeEvent: removeEvent,
      showErrorText: showErrorText,
      errorText: errorText,
      getItemText: null,
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
    this.controller,
    super.key,
    this.tralingList,
    this.enabled,
    this.unfocusSufixIcon,
    this.textFieldChangeEvent,
    this.suffixIconPadding,
    this.focusNode,
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<T> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  final List<String>? values;
  final void Function(String value) removeEvent;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<Widget>? tralingList;
  final bool? enabled;
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
    controller = widget.controller ?? TextEditingController();
    focusNode = (widget.focusNode ?? FocusNode())..onKeyEvent = _handleKeyEvent;
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
      controller.value = TextEditingValue.empty;
      // setState(() {
      //   changeFieldValue = !changeFieldValue;
      // });

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return DropListFieldImplementationWidget<T>(
      textFieldKey: widget.textFieldKey,
      labelText: widget.labelText,
      dropDownList: widget.dropDownList,
      isDesk: widget.isDesk,
      controller: controller,
      errorText: widget.errorText,
      onChanged: null,
      focusNode: focusNode,
      showErrorText: widget.showErrorText,
      optionsBuilder: widget.optionsBuilder,
      unfocusSufixIcon: widget.unfocusSufixIcon,
      enabled: widget.enabled,
      item: widget.item,
      onSelected: (value) {
        widget.onChanged
            ?.call(widget.getItemText?.call(value) ?? value.toString());
        controller
          ..text = ' '
          ..clear();
        FocusScope.of(context).unfocus();
      },
      fieldParentWidget: widget.values != null && widget.values!.isNotEmpty
          ? ({required textField, required suffixIcon}) => Stack(
                children: [
                  textField,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize8,
                      vertical: KPadding.kPaddingSize8,
                    ),
                    child: Row(
                      children: [
                        // const Spacer(),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: CustomScrollBehavior(),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  widget.values!.length,
                                  (index) => Padding(
                                    padding: EdgeInsets.only(
                                      left: index == 0
                                          ? 0
                                          : KPadding.kPaddingSize8,
                                    ),
                                    child: CancelChipWidget(
                                      widgetKey: KWidgetkeys
                                          .widget.multiDropField.chips,
                                      isDesk: widget.isDesk,
                                      labelText:
                                          widget.values!.elementAt(index),
                                      style: KButtonStyles.secondaryButtonStyle
                                          .copyWith(
                                        padding: const WidgetStatePropertyAll(
                                          EdgeInsets.symmetric(
                                            vertical: KPadding.kPaddingSize4,
                                            horizontal: KPadding.kPaddingSize8,
                                          ),
                                        ),
                                      ),
                                      textStyle:
                                          AppTextStyle.materialThemeTitleMedium,
                                      onPressed: () => widget.removeEvent(
                                        widget.values!.elementAt(index),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        KSizedBox.kWidthSizedBox16,
                        suffixIcon,
                      ],
                    ),
                  ),
                ],
              )
          : null,
      suffixIconPadding: KPadding.kPaddingSize8,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }
}
