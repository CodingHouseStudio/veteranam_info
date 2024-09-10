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

class DropDownButtonState extends State<DropDownButton> {
  bool _showButtons = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: KWidgetkeys.widget.dropDownButton.widget,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          key: KWidgetkeys.widget.dropDownButton.loginButton,
          onPressed: () {
            setState(() {
              _showButtons = !_showButtons;
            });
          },
          style: KButtonStyles.borderBlackButtonStyle,
          label: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize4),
            child: Text(
              context.l10n.login,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
          ),
          icon: _showButtons ? KIcon.trailingUp : KIcon.trailing,
        ),
        Visibility(
          visible: _showButtons,
          child: DecoratedBox(
            decoration: KWidgetTheme.boxDecorationHome,
            child: Padding(
              padding: const EdgeInsets.only(
                top: KPadding.kPaddingSize8,
                left: KPadding.kPaddingSize16,
                right: KPadding.kPaddingSize16,
                bottom: KPadding.kPaddingSize16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    key: KWidgetkeys.widget.dropDownButton.businessButton,
                    onPressed: null,
                    style: KButtonStyles.withoutStyle,
                    child: Text(
                      context.l10n.asBusiness,
                      style: AppTextStyle.materialThemeBodyMedium,
                    ),
                  ),
                  KSizedBox.kHeightSizedBox8,
                  TextButton(
                    key: KWidgetkeys.widget.dropDownButton.userButton,
                    onPressed: () => context.goNamed(KRoute.login.name),
                    style: KButtonStyles.withoutStyle,
                    child: Text(
                      context.l10n.asUser,
                      style: AppTextStyle.materialThemeBodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
