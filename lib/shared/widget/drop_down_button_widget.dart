import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  DropDownButtonState createState() => DropDownButtonState();
}

enum ButtonEnum {
  business,
  user,
}

class DropDownButtonState extends State<DropDownButton> {
  bool _showButtons = false;

  @override
  Widget build(BuildContext context) {
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
          // case Button.user:
          //   break;
          case ButtonEnum.user:
            context.goNamed(KRoute.login.name);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          key: KWidgetkeys.widget.dropDownButton.businessButton,
          value: ButtonEnum.business,
          enabled: false,
          padding: const EdgeInsets.only(
            bottom: KPadding.kPaddingSize8,
          ),
          height: AppTextStyle.materialThemeBodyMedium.fontSize!,
          child: Text(
            context.l10n.asBusiness,
            style: AppTextStyle.materialThemeBodyMedium,
          ),
        ),
        PopupMenuItem(
          key: KWidgetkeys.widget.dropDownButton.userButton,
          value: ButtonEnum.user,
          padding: EdgeInsets.zero,
          height: AppTextStyle.materialThemeBodyMedium.fontSize!,
          child: Text(
            context.l10n.asUser,
            style: AppTextStyle.materialThemeBodyMedium,
          ),
        ),
      ],
      icon: Row(
        key: KWidgetkeys.widget.dropDownButton.loginButton,
        children: [
          if (_showButtons) KIcon.trailingUp else KIcon.trailing,
          Text(
            context.l10n.login,
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
