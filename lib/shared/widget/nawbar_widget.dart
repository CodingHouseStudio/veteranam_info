import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class NawbarWidget extends StatefulWidget implements PreferredSizeWidget {
  const NawbarWidget({required this.isDesk, required this.padding, super.key});
  final bool isDesk;
  final EdgeInsets padding;

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
    return Padding(
      padding: widget.padding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: KBorderRadius.kBorderRadius32,
          color: AppColors.widgetBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(KPadding.kPaddingSize10),
          child: Row(
            children: [
              if (widget.isDesk || !isFocused)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize30,
                  ),
                  child: InkWell(
                    onTap: () => EasyDebounce.debounce(
                      context.l10n.logo,
                      const Duration(milliseconds: 500),
                      () => context.go(KRoute.home.path),
                    ),
                    child: Text(
                      context.l10n.logo,
                      key: KWidgetkeys.widget.nawbar.title,
                      style: widget.isDesk
                          ? AppTextStyle.text32
                          : AppTextStyle.text24,
                    ),
                  ),
                ),
              Expanded(
                child: TextFieldWidget(
                  key: _formKey,
                  widgetKey: KWidgetkeys.widget.nawbar.field,
                  hintStyle:
                      widget.isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                  focusNode: focusNode,
                  prefixIcon: KIcon.search,
                  onChanged: (text) {},
                  hintText: context.l10n.search,
                  suffixIcon: widget.isDesk
                      ? null
                      : KIcon.mic.setIconKey(
                          KWidgetkeys.widget.nawbar.iconMic,
                        ),
                  border: KBorder.outlineInputTransparent,
                  enabledBorder: KBorder.outlineInputTransparent,
                  focusedBorder: KBorder.outlineInputTransparent,
                  disposeFocusNode: false,
                ),
              ),
              if (widget.isDesk)
                Row(
                  children: [
                    IconWidget(
                      key: KWidgetkeys.widget.nawbar.iconMic,
                      icon: KIcon.mic,
                    ),
                    KSizedBox.kWidthSizedBox10,
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
                    // fail test, I need mobile design for this button
                    const LanguagesSwitcherWidget(),
                  ],
                ),
              if (widget.isDesk || !isFocused)
                IconWidget(
                  key: KWidgetkeys.widget.nawbar.iconPerson,
                  icon: KIcon.person,
                ),
            ],
          ),
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
