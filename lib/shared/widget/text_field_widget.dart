import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    required this.widgetKey,
    required this.onChanged,
    required this.hintText,
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
  final ValueChanged<String> onChanged;
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

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final Widget customTextField = TextField(
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
      style: KAppTextStyle.lableMedium,
      // Theme.of(context).textTheme.headlineSmall,
      key: widget.widgetKey,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintStyle: widget.hintStyle ?? KAppTextStyle.hint,
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.only(left: 20, right: 20),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: widget.labelText,
        border: kIsWeb
            ? widget.border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: KColorTheme.lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )
            : widget.border,
        enabledBorder: kIsWeb
            ? widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: KColorTheme.lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )
            : widget.enabledBorder ??
                Theme.of(context).inputDecorationTheme.enabledBorder,
        disabledBorder: kIsWeb
            ? widget.border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: KColorTheme.lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )
            : widget.border,
        focusedBorder: kIsWeb
            ? widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: KColorTheme.lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )
            : widget.focusedBorder ??
                Theme.of(context).inputDecorationTheme.focusedBorder,
        focusedErrorBorder: kIsWeb
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: KColorTheme.c52707),
                borderRadius: BorderRadius.zero,
              )
            : widget.border,
        filled: true,
        fillColor: widget.fillColor ?? KColorTheme.typographyPrimary,
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        errorMaxLines: widget.errorMaxLines,
      ),
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: customTextField,
    );
  }

  @override
  void dispose() {
    if (widget.disposeFocusNode != null && widget.disposeFocusNode!) {
      widget.focusNode?.dispose();
    }
    super.dispose();
  }
}
