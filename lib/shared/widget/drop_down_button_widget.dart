import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({
    required this.isDesk,
    required this.buttonText,
    required this.textItems,
    super.key,
  });

  final bool isDesk;
  final String buttonText;
  final List<String> textItems;

  @override
  DropDownButtonState createState() => DropDownButtonState();
}

enum LoginButtonsEnum {
  business,
  user,
}

class DropDownButtonState extends State<DropDownButton> {
  bool _showButtons = false;

  @override
  Widget build(BuildContext context) {
    //After the implementation of the login page as a Business account,
    //change enum to LoginButtonsEnum
    return PopupMenuButton<Enum>(
      key: KWidgetkeys.widget.dropDownButton.widget,
      offset: const Offset(140, 45),
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
      onSelected: (value) {
        switch (value) {
          case LoginButtonsEnum.user:
            context.goNamed(KRoute.login.name);
          //case LoginButtonsEnum.business:
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          key: KWidgetkeys.widget.dropDownButton.businessButton,
          value: LoginButtonsEnum.business,
          enabled: false,
          padding: const EdgeInsets.only(
            bottom: KPadding.kPaddingSize8,
          ),
          height: AppTextStyle.materialThemeBodyMedium.fontSize!,
          child: Text(
            widget.textItems[0],
            style: AppTextStyle.materialThemeBodyMedium,
          ),
        ),
        PopupMenuItem(
          key: KWidgetkeys.widget.dropDownButton.userButton,
          value: LoginButtonsEnum.user,
          padding: EdgeInsets.zero,
          height: AppTextStyle.materialThemeBodyMedium.fontSize!,
          child: Text(
            widget.textItems[1],
            style: AppTextStyle.materialThemeBodyMedium,
          ),
        ),
      ],
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
