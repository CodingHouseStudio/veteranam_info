import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veteranam/shared/shared.dart';

class MultiDropFieldWidget extends StatefulWidget {
  const MultiDropFieldWidget({
    required this.onChanged,
    required this.labelText,
    required this.dropDownList,
    required this.isDesk,
    required this.values,
    required this.removeEvent,
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
  final List<String>? values;
  final void Function(String value) removeEvent;

  @override
  State<MultiDropFieldWidget> createState() => _MultiDropFieldWidgetState();
}

class _MultiDropFieldWidgetState extends State<MultiDropFieldWidget> {
  late TextEditingController textController;
  late FocusNode _focusNode;
  late bool listFocusManager;
  late String labelText;
  @override
  void initState() {
    super.initState();
    listFocusManager = false;
    _focusNode = FocusNode();
    labelText = (widget.values?.isEmpty ?? true) ? widget.labelText : '';
    textController = widget.controller ?? TextEditingController();
    _focusNode.onKeyEvent = _handleKeyEvent;
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
      widget.onChanged?.call(textController.text);
      _focusNode.unfocus();
      textController.clear();
      setState(() {
        listFocusManager = !listFocusManager;
      });

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return DropListFieldImplementationWidget(
      key: ValueKey(listFocusManager),
      labelText: widget.labelText,
      dropDownList: widget.dropDownList,
      isDesk: widget.isDesk,
      controller: textController,
      errorText: widget.errorText,
      onChanged: (text) {
        widget.onChanged?.call(text);
        textController.clear();
      },
      focusNode: _focusNode,
      showErrorText: widget.showErrorText,
      elementList: List.generate(
        widget.values?.length ?? 0,
        (index) => Padding(
          padding:
              EdgeInsets.only(left: index == 0 ? 0 : KPadding.kPaddingSize8),
          child: CancelChipWidget(
            widgetKey: KWidgetkeys.widget.multiDropField.chips,
            isDesk: widget.isDesk,
            labelText: widget.values!.elementAt(index),
            style: KButtonStyles.secondaryButtonStyle.copyWith(
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  vertical: KPadding.kPaddingSize4,
                  horizontal: KPadding.kPaddingSize8,
                ),
              ),
            ),
            textStyle: AppTextStyle.materialThemeTitleMedium,
            onPressed: () =>
                widget.removeEvent(widget.values!.elementAt(index)),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
