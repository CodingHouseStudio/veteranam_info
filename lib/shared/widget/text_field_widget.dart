import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veteranam/shared/shared.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    required this.widgetKey,
    required this.onChanged,
    required this.isDesk,
    this.hintText,
    this.textAlign,
    super.key,
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
    // this.text,
    this.suffixIconPadding,
    this.inputFormatterList,
    this.showErrorText,
  });
  final Key widgetKey;
  final TextAlign? textAlign;
  final ValueChanged<String>? onChanged;
  final String? hintText;
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
  final bool disposeFocusNode;
  final bool? expands;
  final String? labelText;
  final TextStyle? hintStyle;
  final bool isDesk;
  // final String? text;
  final double? suffixIconPadding;
  final List<TextInputFormatter>? inputFormatterList;
  final bool? showErrorText;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController? controller;
  late bool isHovered;

  @override
  void initState() {
    // if (widget.text != null) {
    //   controller = TextEditingController(text: widget.text);
    // }
    isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
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
        controller: controller ?? widget.controller,
        maxLines: widget.expands == null ? widget.maxLines ?? 1 : null,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.done,
        textAlign: widget.textAlign ?? TextAlign.start,
        style: AppTextStyle.materialThemeTitleMedium,
        // context.theme.textTheme.headlineSmall,
        inputFormatters: widget.inputFormatterList,
        onChanged: widget.onChanged,
        decoration: KWidgetTheme.inputDecoration.copyWith(
          hintStyle: widget.hintStyle,
          contentPadding: widget.contentPadding ??
              (widget.isDesk
                  ? const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize32,
                      vertical: KPadding.kPaddingSize16,
                    )
                  : const EdgeInsets.all(KPadding.kPaddingSize16)),
          labelText: widget.labelText,
          border: widget.border,
          enabledBorder: KWidgetTheme.outlineInputBorderEnabled.copyWith(
            borderSide: isHovered
                ? const BorderSide(
                    color: AppColors.materialThemeRefNeutralNeutral40,
                  )
                : null,
          ),
          focusedErrorBorder: widget.border,
          fillColor: widget.fillColor,
          hintText: widget.hintText,
          errorText: widget.showErrorText ?? true ? widget.errorText : null,
          suffixIcon: Padding(
            padding: EdgeInsets.only(
              right: widget.suffixIconPadding ?? KPadding.kPaddingSize4,
            ),
            child: widget.suffixIcon,
          ),
          prefixIcon: widget.prefixIcon,
          errorMaxLines: widget.errorMaxLines,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.disposeFocusNode) {
      widget.focusNode?.dispose();
    }
    // if (widget.text != null) {
    //   controller?.dispose();
    // }
    super.dispose();
  }
}
