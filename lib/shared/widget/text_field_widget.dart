import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    required this.widgetKey,
    required this.hintText,
    required this.onChanged,
    required this.isDesk,
    this.textAlign,
    super.key,
    this.width,
    this.height,
    this.errorText,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.contentPadding,
    this.border,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.fillColor,
    this.onEditingCompleted,
    this.onSubmitted,
    this.enabled = true,
    this.focusNode,
    this.enabledBorder,
    this.focusedBorder,
    this.errorMaxLines,
    this.readOnly,
    this.disposeFocusNode = true,
    this.expands,
    this.labelText,
    this.minLines,
    this.hintStyle,
  });
  final Key widgetKey;
  final double? width;
  final double? height;
  final TextAlign? textAlign;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final OutlineInputBorder? border;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final Color? fillColor;
  final void Function()? onEditingCompleted;
  final void Function(String)? onSubmitted;
  final bool? enabled;
  final FocusNode? focusNode;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final int? errorMaxLines;
  final bool? readOnly;
  final bool? disposeFocusNode;
  final bool? expands;
  final String? labelText;
  final TextStyle? hintStyle;
  final bool isDesk;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        key: widget.widgetKey,
        expands: widget.expands ?? false,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        readOnly: widget.readOnly ?? false,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingCompleted,
        obscureText: widget.obscureText,
        autocorrect: !widget.obscureText,
        controller: widget.controller,
        maxLines: widget.expands == null ? widget.maxLines ?? 1 : null,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.done,
        textAlign: widget.textAlign ?? TextAlign.start,
        style: widget.isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        // context.theme.textTheme.headlineSmall,
        onChanged: widget.onChanged,
        decoration: context.widgetTheme.inputDecoration.copyWith(
          hintStyle: widget.hintStyle,
          contentPadding: widget.contentPadding ??
              (widget.isDesk
                  ? const EdgeInsets.all(KPadding.kPaddingSize24)
                  : const EdgeInsets.all(KPadding.kPaddingSize16)),
          labelText: widget.labelText,
          border: widget.border,
          enabledBorder: widget.enabledBorder,
          disabledBorder: widget.border,
          focusedBorder: widget.focusedBorder,
          focusedErrorBorder: kIsWeb ? null : widget.border,
          fillColor: widget.fillColor,
          hintText: widget.hintText,
          errorText: widget.errorText,
          errorStyle: context.textStyle.error14,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          errorMaxLines: widget.errorMaxLines,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.disposeFocusNode ?? false) {
      widget.focusNode?.dispose();
    }
    super.dispose();
  }
}
