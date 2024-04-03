import 'package:flutter/material.dart';
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
            left: KPadding.kPaddingSizeXXL *
                (isMobile
                    ? KPlatformConstants.mobilePaddingKoefficient
                    : (isTablet
                        ? KPlatformConstants.tabletPaddingKoefficient
                        : KPlatformConstants.desktopPaddingKoefficient)),
            right: KPadding.kPaddingSizeXXL *
                (isMobile
                    ? KPlatformConstants.mobilePaddingKoefficient
                    : (isTablet
                        ? KPlatformConstants.tabletPaddingKoefficient
                        : KPlatformConstants.desktopPaddingKoefficient)),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: KBorderRadius.kBorderRadiusM,
              color: AppColors.widgetBackground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
              child: Row(
                children: [
                  if (isDesktop || !isFocused)
                    Row(
                      children: [
                        KSizedBox.kWidthSizedBoxM,
                        Text(
                          KAppText.logo,
                          key: KWidgetkeys.nawbarKeys.title,
                          style: isDesktop
                              ? AppTextStyle.titleML
                              : AppTextStyle.titleM,
                        ),
                        KSizedBox.kWidthSizedBoxML,
                      ],
                    ),
                  Expanded(
                    child: TextFieldWidget(
                      key: _formKey,
                      widgetKey: KWidgetkeys.nawbarKeys.field,
                      hintStyle:
                          isDesktop ? AppTextStyle.lableM : AppTextStyle.lableS,
                      focusNode: focusNode,
                      prefixIcon: KIcon.search,
                      onChanged: (text) {},
                      hintText: KAppText.searchTextFieldHint,
                      suffixIcon: isDesktop
                          ? null
                          : Container(
                              key: KWidgetkeys.nawbarKeys.iconMic,
                              child: KIcon.mic,
                            ),
                      border: KBorder.outlineInputTransparent,
                      enabledBorder: KBorder.outlineInputTransparent,
                      focusedBorder: KBorder.outlineInputTransparent,
                      disposeFocusNode: false,
                    ),
                  ),
                  if (isDesktop)
                    Row(
                      children: [
                        IconWidget(
                          key: KWidgetkeys.nawbarKeys.iconMic,
                          icon: KIcon.mic,
                        ),
                        KSizedBox.kWidthSizedBoxML,
                        TextButton(
                          key: KWidgetkeys.nawbarKeys.button,
                          style: KButtonStyles.whiteButtonStyle,
                          onPressed: null,
                          child: const Text(
                            KAppText.enterButtonText,
                            style: AppTextStyle.lableM,
                          ),
                        ),
                      ],
                    ),
                  if (isDesktop || !isFocused)
                    IconWidget(
                      key: KWidgetkeys.nawbarKeys.iconPerson,
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
