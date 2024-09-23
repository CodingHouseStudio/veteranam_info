import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class TextFieldDescriptionWidget extends StatelessWidget {
  const TextFieldDescriptionWidget({
    required this.widgetKey,
    required this.isDesk,
    required this.description,
    required this.labelText,
    super.key,
    this.onChanged,
    this.suffixIcon,
    this.showErrorText,
    this.errorText,
    this.isMessage,
    this.errorMaxLines,
    this.maxLength,
    this.controller,
    this.childWidget,
  });
  final String? labelText;
  final Key? widgetKey;
  final void Function(String)? onChanged;
  final bool isDesk;
  final Widget? suffixIcon;
  final bool? showErrorText;
  final String? errorText;
  final String description;
  final bool? isMessage;
  final int? errorMaxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (childWidget != null)
          childWidget!
        else if (isMessage ?? false)
          MessageFieldWidget(
            key: widgetKey,
            controller: controller,
            labelText: labelText,
            changeMessage: onChanged,
            isDesk: isDesk,
            showErrorText: showErrorText,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
          )
        else
          TextFieldWidget(
            widgetKey: widgetKey ?? ValueKey(labelText),
            controller: controller,
            labelText: labelText,
            onChanged: onChanged,
            isDesk: isDesk,
            suffixIcon: suffixIcon,
            showErrorText: showErrorText,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
            maxLength: maxLength,
          ),
        KSizedBox.kHeightSizedBox8,
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize32),
          child: Text(
            description,
            style: AppTextStyle.materialThemeBodySmall,
          ),
        ),
      ],
    );
  }
}
