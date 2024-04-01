import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class NawbarWidget extends StatefulWidget implements PreferredSizeWidget {
  const NawbarWidget({required this.search, super.key});

  final void Function(String text) search;

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusM,
        color: AppColors.widgetBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final isMobile = constraints.maxWidth <
                PlatformConstants.minWidthThresholdMobile;
            return Row(
              children: [
                if (!(isMobile && isFocused))
                  Row(
                    children: [
                      KSizedBox.kWidthSizedBoxM,
                      Text(
                        KAppText.appName,
                        key: KWidgetkeys.nawbarKeys.title,
                        style: AppTextStyle.title,
                      ),
                      KSizedBox.kWidthSizedBoxML,
                    ],
                  ),
                Expanded(
                  child: TextFieldWidget(
                    key: _formKey,
                    widgetKey: KWidgetkeys.nawbarKeys.field,
                    hintStyle: AppTextStyle.lableMedium,
                    focusNode: focusNode,
                    prefixIcon: KIcon.search,
                    onChanged: widget.search,
                    hintText: KAppText.searchTextFieldHint,
                    suffixIcon: isMobile
                        ? Container(
                            key: KWidgetkeys.nawbarKeys.iconMic,
                            child: KIcon.mic,
                          )
                        : null,
                    border: KBorder.outlineInputTransparent,
                    enabledBorder: KBorder.outlineInputTransparent,
                    focusedBorder: KBorder.outlineInputTransparent,
                    disposeFocusNode: false,
                  ),
                ),
                if (!isMobile)
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
                          style: AppTextStyle.lableMedium,
                        ),
                      ),
                    ],
                  ),
                if (!(isMobile && isFocused))
                  IconWidget(
                    key: KWidgetkeys.nawbarKeys.iconPerson,
                    icon: KIcon.person,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
