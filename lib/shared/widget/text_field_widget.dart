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
    this.isDesk = true,
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
  final bool? isDesk;

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
        style:
            widget.isDesk ?? true ? AppTextStyle.text24 : AppTextStyle.text16,
        // Theme.of(context).textTheme.headlineSmall,
        key: widget.widgetKey,
        onChanged: widget.onChanged,
        decoration: KWidetTheme.inputDecoration.copyWith(
          hintStyle: widget.hintStyle,
          contentPadding: widget.contentPadding ??
              (widget.isDesk ?? true
                  ? null
                  : const EdgeInsets.all(KPadding.kPaddingSize16)),
          labelText: widget.labelText,
          border: kIsWeb ? widget.border : widget.border,
          enabledBorder: kIsWeb ? widget.enabledBorder : widget.enabledBorder,
          //??
          // Theme.of(context).inputDecorationTheme.enabledBorder,
          disabledBorder: kIsWeb ? widget.border : widget.border,
          focusedBorder: kIsWeb ? widget.focusedBorder : widget.focusedBorder,
          //??
          //Theme.of(context).inputDecorationTheme.focusedBorder,
          focusedErrorBorder: kIsWeb ? null : widget.border,
          fillColor: widget.fillColor,
          hintText: widget.hintText,
          errorText: widget.errorText,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          errorMaxLines: widget.errorMaxLines,
        ),
      ),
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
