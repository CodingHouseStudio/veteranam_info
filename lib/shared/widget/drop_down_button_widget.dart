import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({
    required this.isDesk,
    required this.buttonText,
    required this.items,
    required this.offset,
    super.key,
  });

  final bool isDesk;
  final String buttonText;
  final List<DropDownItem> items;
  final Offset offset;

  @override
  DropDownButtonState createState() => DropDownButtonState();
}

class DropDownButtonState extends State<DropDownButton> {
  bool _showButtons = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      key: KWidgetkeys.widget.dropDownButton.widget,
      offset: widget.offset,
      shape: const RoundedRectangleBorder(
        borderRadius: KBorderRadius.kBorderRadius32,
      ),
      style: KButtonStyles.borderBlackButtonStyle.copyWith(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.only(
            left: KPadding.kPaddingSize4,
            right: KPadding.kPaddingSize12,
          ),
        ),
      ),
      menuPadding: const EdgeInsets.all(
        KPadding.kPaddingSize16,
      ),
      color: AppColors.materialThemeKeyColorsNeutral,
      padding: EdgeInsets.zero,
      onCanceled: onTap,
      onOpened: onTap,
      onSelected: (index) {
        widget.items.elementAt(index).action?.call();
      },
      itemBuilder: (context) {
        return List.generate(widget.items.length, (index) {
          return PopupMenuItem(
            key: widget.items.elementAt(index).key,
            value: index,
            padding: index != widget.items.length
                ? const EdgeInsets.only(
                    bottom: KPadding.kPaddingSize8,
                  )
                : EdgeInsets.zero,
            height: AppTextStyle.materialThemeBodyMedium.fontSize!,
            child: Text(
              widget.items.elementAt(index).text,
              style: AppTextStyle.materialThemeBodyMedium,
            ),
          );
        });
      },
      icon: Row(
        key: KWidgetkeys.widget.dropDownButton.loginButton,
        children: [
          if (_showButtons) KIcon.trailingUp else KIcon.trailing,
          KSizedBox.kWidthSizedBox8,
          Text(
            widget.buttonText,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ],
      ),
    );
  }

  void onTap() => setState(() {
        _showButtons = !_showButtons;
      });
}
