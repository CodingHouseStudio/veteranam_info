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
      isLoading: dropDownList.isEmpty,
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
    required this.isLoading,
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
    this.errorMaxLines,
    this.description,
    this.textStyle,
    this.unenabledList = const [],
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
  final Key textFieldKey;
  final int? errorMaxLines;
  final String? description;
  final TextStyle? textStyle;
  final List<T>? unenabledList;
  final bool isLoading;

  @override
  State<DropListFieldImplementationWidget<T>> createState() =>
      _DropListFieldImplementationWidgetState();
}

class _DropListFieldImplementationWidgetState<T extends Object>
    extends State<DropListFieldImplementationWidget<T>> {
  late GlobalKey _anchorKey;
  late GlobalKey _menuKey;
  late TextEditingController controller;
  late FocusNode focusNode;
  late bool showActiveIcon;
  late double? menuHeight;

  @override
  void initState() {
    super.initState();
    _initializeController();
    showActiveIcon = false;
    menuHeight = null;

    _anchorKey = GlobalKey();
    _menuKey = GlobalKey();
  }

  @override
  void didUpdateWidget(
    covariant DropListFieldImplementationWidget<T> oldWidget,
  ) {
    if (widget.isDesk != oldWidget.isDesk) {
      menuHeight = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initializeController() {
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(_changeIcon);
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

  void setMenuHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _menuKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject()! as RenderBox;
        if (box.hasSize) {
          setState(() {
            menuHeight = box.size.height;
          });
        }
      }
    });
  }

  double get menuMaxHeight =>
      widget.isDesk ? KMinMaxSize.maxHeight400 : KMinMaxSize.maxHeight220;

  OptionsViewOpenDirection get optionsViewOpenDirection {
    if (context.findRenderObject() == null) {
      return OptionsViewOpenDirection.down;
    }

    final renderBox = context.findRenderObject()! as RenderBox;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final availableHeight =
        screenHeight - (renderBox.localToGlobal(Offset.zero).dy + getHeight);
    // +
    //     (widget.isDesk ? KSize.kPixel70 : -KSize.kPixel20);
    return availableHeight > (menuHeight ?? menuMaxHeight)
        ? OptionsViewOpenDirection.down
        : OptionsViewOpenDirection.up;
  }

  bool buttonEnabled(T option) {
    if (widget.unenabledList == null) {
      return false;
    } else if (widget.unenabledList != null) {
      if (widget.unenabledList!.isNotEmpty &&
          widget.unenabledList!.contains(option)) {
        return false;
      }
    }
    return true;
  }

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
        if (!widget.isLoading && menuHeight == null) setMenuHeight();

        return Align(
          alignment: optionsViewOpenDirection == OptionsViewOpenDirection.down
              ? Alignment.topLeft
              : Alignment.bottomLeft,
          child: Container(
            key: _menuKey,
            constraints: BoxConstraints(
              maxHeight: menuMaxHeight,
              maxWidth: getWidth,
            ),
            margin: const EdgeInsets.only(
              top: KPadding.kPaddingSize4,
              bottom: KPadding.kPaddingSize8,
            ),
            decoration: KWidgetTheme.boxDecorationCard.copyWith(
              boxShadow: KWidgetTheme.dropMenuboxShadow,
            ),
            clipBehavior: Clip.hardEdge,
            child: ListView.builder(
              key: KWidgetkeys.widget.dropListField.list,
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize16,
              ),
              // prototypeItem: TextButton(
              //   onPressed: null,
              //   style: KButtonStyles.dropListButtonStyle,
              //   child: widget.items(options.elementAt(0)),
              // ),
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return Padding(
                  padding: index == 0
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(top: KPadding.kPaddingSize8),
                  child: TextButton(
                    key: KWidgetkeys.widget.dropListField.item,
                    onPressed: buttonEnabled(option)
                        ? () {
                            focusNode.unfocus();
                            onSelected(option);
                          }
                        : null,
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
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFieldWidget(
        key: _anchorKey, //KWidgetkeys.widget.dropListField.field,
        widgetKey: widget.textFieldKey,
        controller: controller,
        focusNode: focusNode,
        suffixIcon: _suffixIcon,
        onChanged: widget.onChanged,
        labelText: widget.labelText,
        showErrorText: widget.showErrorText,
        errorText: widget.errorText,
        suffixIconPadding: widget.suffixIconPadding,
        disposeFocusNode: false,
        isDesk: widget.isDesk, textStyle: widget.textStyle,
        readOnly: widget.isButton,
        cursor: widget.isButton ?? false ? SystemMouseCursors.click : null,
        disabledBorder: KWidgetTheme.outlineInputBorderEnabled,
        errorMaxLines: widget.errorMaxLines, description: widget.description,
      ),
    );
  }

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
