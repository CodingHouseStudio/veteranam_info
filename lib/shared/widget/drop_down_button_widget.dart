import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({
    required this.isDesk,
    required this.items,
    required this.offset,
    required this.style,
    super.key,
    this.discountButtons = false,
    this.buttonText,
  });

  final bool isDesk;
  final String? buttonText;
  final List<DropDownItem> items;
  final Offset offset;
  final bool discountButtons;
  final ButtonStyle style;

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
      position: PopupMenuPosition.under,
      shape: KWidgetTheme.outlineBorder,
      style: widget.style,
      tooltip: '',
      menuPadding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize8,
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
          return PopupMenuItemWidget(
            key: widget.items.elementAt(index).key,
            //onTap: widget.items.elementAt(index).action,
            value: index,
            child: widget.discountButtons
                ? Row(
                    children: [
                      widget.items.elementAt(index).icon!,
                      KSizedBox.kWidthSizedBox16,
                      Text(
                        widget.items.elementAt(index).text,
                        style: AppTextStyle.materialThemeBodyMedium,
                      ),
                    ],
                  )
                : Text(
                    widget.items.elementAt(index).text,
                    style: AppTextStyle.materialThemeBodyMedium,
                  ),
          );
        });
      },
      icon: widget.buttonText != null
          ? Row(
              key: KWidgetkeys.widget.dropDownButton.loginButton,
              children: [
                if (_showButtons) KIcon.trailingUp else KIcon.keyboardArrowDown,
                KSizedBox.kWidthSizedBox8,
                Text(
                  widget.buttonText!,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
              ],
            )
          : const Padding(
              padding: EdgeInsets.all(
                KPadding.kPaddingSize12,
              ),
              child: IconWidget(
                icon: KIcon.moreVert,
                background: AppColors.materialThemeKeyColorsNeutral,
                padding: 0,
              ),
            ),
    );
  }

  void onTap() => setState(() {
        _showButtons = !_showButtons;
      });
}
