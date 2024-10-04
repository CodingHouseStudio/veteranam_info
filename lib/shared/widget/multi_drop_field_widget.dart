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
  });

  final void Function(String text)? onChanged;
  final String labelText;
  final List<String> dropDownList;
  final bool isDesk;
  final bool? showErrorText;
  final String? errorText;
  // final TextEditingController? controller;
  final List<String>? values;
  final void Function(String value) removeEvent;
  final Key textFieldKey;
  final int? errorMaxLines;
  final bool? isButton;
  final String? description;
  final String? allElemts;

  @override
  Widget build(BuildContext context) {
    return MultiDropFieldImplementationWidget<String>(
      textFieldKey: textFieldKey,
      onChanged: onChanged,
      labelText: labelText,
      dropDownList: dropDownList, allElemts: allElemts,
      isDesk: isDesk,
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
  final void Function(String value) removeEvent;
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

  @override
  State<MultiDropFieldImplementationWidget<T>> createState() =>
      _MultiDropFieldImplementationWidgetState<T>();
}

class _MultiDropFieldImplementationWidgetState<T extends Object>
    extends State<MultiDropFieldImplementationWidget<T>> {
  late TextEditingController controller;
  late FocusNode focusNode;
  late GlobalKey _anchorKey;
  late int lines;
  @override
  void initState() {
    super.initState();
    lines = 1;
    controller = TextEditingController();
    focusNode = (widget.focusNode ?? FocusNode())
      ..onKeyEvent = _handleKeyEvent
      ..addListener(_unFocusData);
    _anchorKey = GlobalKey(debugLabel: 'multi ${widget.labelText}');
  }

  void _unFocusData() {
    if (!focusNode.hasFocus && controller.text.isNotEmpty) {
      widget.onChanged?.call(controller.text);
      controller.clear();
    }
  }

  void getLines() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _anchorKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject()! as RenderBox;
        if (box.hasSize) {
          final linesValue =
              ((box.size.height - KSize.kPixel80) / KSize.kPixel30).ceil() + 1;
          if (linesValue >= 1 && lines != linesValue) {
            setState(() {
              lines = linesValue;
            });
          }
        }
      }
    });
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
      allElemts: widget.allElemts,
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
        controller
          ..text = ' '
          ..clear();
        FocusScope.of(context).unfocus();
      },
      textStyle: AppTextStyle.materialThemeTitleMedium.copyWith(
        height: lines > 1 ? 1.9 : 1.5,
      ),
      fieldParentWidget: (widget.values == null && widget.allElemts != null) ||
              widget.values!.isNotEmpty
          ? ({required textField, required suffixIcon}) {
              return Stack(
                children: [
                  textField,
                  Row(
                    key: _anchorKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: focusNode.hasFocus &&
                                    !(widget.isButton ?? false)
                                ? widget.isDesk
                                    ? KPadding.kPaddingSize32
                                    : KPadding.kPaddingSize16
                                : KPadding.kPaddingSize8,
                            top: KPadding.kPaddingSize4,
                            bottom: widget.isDesk ? KPadding.kPaddingSize16 : 0,
                          ),
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: controller,
                            builder: (context, value, child) {
                              getLines();
                              return RichText(
                                text: TextSpan(
                                  text: value.text,
                                  style: AppTextStyle.materialThemeTitleMedium
                                      .copyWith(
                                    height: lines > 1 ? 1.9 : 1.5,
                                    color: Colors.transparent,
                                  ),
                                  children: [
                                    if (focusNode.hasFocus &&
                                        !(widget.isButton ?? false))
                                      const WidgetSpan(
                                        alignment:
                                            PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: KSizedBox.kWidthSizedBox8,
                                      ),
                                    ...List.generate(
                                      widget.values?.length ?? 1,
                                      (index) => WidgetSpan(
                                        style: const TextStyle(height: 1),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right: KPadding.kPaddingSize8,
                                            top: widget.isDesk
                                                ? KPadding.kPaddingSize4
                                                : 0,
                                          ),
                                          child: CancelChipWidget(
                                            widgetKey: KWidgetkeys
                                                .widget.multiDropField.chips,
                                            isDesk: widget.isDesk,
                                            labelText: getValue(index),
                                            style: KButtonStyles
                                                .secondaryButtonStyle
                                                .copyWith(
                                              alignment: Alignment.centerLeft,
                                              padding:
                                                  const WidgetStatePropertyAll(
                                                EdgeInsets.only(
                                                  left: KPadding.kPaddingSize12,
                                                  right:
                                                      KPadding.kPaddingSize24,
                                                ),
                                              ),
                                            ),
                                            textStyle: widget.isDesk
                                                ? AppTextStyle
                                                    .materialThemeTitleMedium
                                                : AppTextStyle
                                                    .materialThemeTitleSmall,
                                            onPressed: () => widget.removeEvent(
                                              getValue(index),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      KSizedBox.kWidthSizedBox4,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: focusNode.hasFocus
                              ? KPadding.kPaddingSize4
                              : widget.isDesk
                                  ? KPadding.kPaddingSize12
                                  : KPadding.kPaddingSize16,
                        ),
                        child: suffixIcon,
                      ),
                      if (focusNode.hasFocus)
                        KSizedBox.kWidthSizedBox4
                      else if (widget.isDesk)
                        KSizedBox.kWidthSizedBox8
                      else
                        KSizedBox.kWidthSizedBox12,
                    ],
                  ),
                ],
              );
            }
          : null,
      suffixIconPadding: KPadding.kPaddingSize8,
      lines: lines,
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
