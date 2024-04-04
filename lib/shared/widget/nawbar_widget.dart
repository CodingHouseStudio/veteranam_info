import 'package:flutter/material.dart';
import 'package:kozak/l10n/l10n.dart';
import 'package:kozak/shared/shared.dart';

class NawbarWidget extends StatefulWidget implements PreferredSizeWidget {
  const NawbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(KSize.kPreferredSize);

  @override
  State<NawbarWidget> createState() => _NawbarWidgetState();

  @override
  StatefulElement createElement() {
    return StatefulElement(this);
  }
}

class _NawbarWidgetState extends State<NawbarWidget> {
  late FocusNode focusNode;
  late bool isFocused = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(
      () => setState(() {
        isFocused = focusNode.hasFocus;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isMobile =
            constraints.maxWidth < KPlatformConstants.minWidthThresholdMobile;
        final isTablet = constraints.maxWidth >=
                KPlatformConstants.minWidthThresholdMobile &&
            constraints.maxWidth < KPlatformConstants.minWidthThresholdDesktop;
        final isDesktop =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesktop;

        return Padding(
          padding: EdgeInsets.only(
            left: KPadding.kPaddingSize75 *
                (isMobile
                    ? KPlatformConstants.mobilePaddingKoefficient
                    : (isTablet
                        ? KPlatformConstants.tabletPaddingKoefficient
                        : KPlatformConstants.desktopPaddingKoefficient)),
            right: KPadding.kPaddingSize75 *
                (isMobile
                    ? KPlatformConstants.mobilePaddingKoefficient
                    : (isTablet
                        ? KPlatformConstants.tabletPaddingKoefficient
                        : KPlatformConstants.desktopPaddingKoefficient)),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: KBorderRadius.kBorderRadius32,
              color: AppColors.widgetBackground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize10),
              child: Row(
                children: [
                  if (isDesktop || !isFocused)
                    Row(
                      children: [
                        KSizedBox.kWidthSizedBox30,
                        Text(
                          context.l10n.logo,
                          key: KWidgetkeys.widget.nawbar.title,
                          style: isDesktop
                              ? AppTextStyle.text32
                              : AppTextStyle.text24,
                        ),
                        KSizedBox.kWidthSizedBox48,
                      ],
                    ),
                  Expanded(
                    child: TextFieldWidget(
                      key: _formKey,
                      widgetKey: KWidgetkeys.widget.nawbar.field,
                      hintStyle:
                          isDesktop ? AppTextStyle.text24 : AppTextStyle.text16,
                      focusNode: focusNode,
                      prefixIcon: KIcon.search,
                      onChanged: (text) {},
                      hintText: context.l10n.search,
                      suffixIcon: isDesktop
                          ? null
                          : Container(
                              key: KWidgetkeys.widget.nawbar.iconMic,
                              child: KIcon.mic,
                            ),
                      border: KBorder.outlineInputTransparent,
                      enabledBorder: KBorder.outlineInputTransparent,
                      focusedBorder: KBorder.outlineInputTransparent,
                      disposeFocusNode: false,
                    ),
                  ),
                  if (isDesktop)
                    IconWidget(
                      key: KWidgetkeys.widget.nawbar.iconMic,
                      icon: KIcon.mic,
                    ),
                  KSizedBox.kWidthSizedBox10,
                  if (isDesktop)
                    TextButton(
                      key: KWidgetkeys.widget.nawbar.button,
                      style: KButtonStyles.whiteButtonStyle,
                      onPressed: null,
                      child: Text(
                        context.l10n.login,
                        style: AppTextStyle.text24,
                      ),
                    ),
                  KSizedBox.kWidthSizedBox10,
                  const LanguagesSwitcherWidget(),
                  if (isDesktop || !isFocused)
                    IconWidget(
                      key: KWidgetkeys.widget.nawbar.iconPerson,
                      icon: KIcon.person,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
