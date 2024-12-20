import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterListWidget extends StatefulWidget {
  const AdvancedFilterListWidget({
    required this.isDesk,
    required this.list,
    required this.textKey,
    required this.title,
    required this.value,
    required this.onCancelWidgetPressed,
    super.key,
  });
  final bool isDesk;
  final Widget list;
  final Key textKey;
  final String title;
  final FilterItem? value;
  final void Function(String activeItem) onCancelWidgetPressed;

  @override
  State<AdvancedFilterListWidget> createState() =>
      _AdvancedFilterListWidgetState();
}

class _AdvancedFilterListWidgetState extends State<AdvancedFilterListWidget> {
  late bool listShow;
  @override
  void initState() {
    listShow = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        right: KPadding.kPaddingSize8,
        bottom: KPadding.kPaddingSize8,
      ),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: widget.value != null && !widget.isDesk
                ? Wrap(
                    runSpacing: KPadding.kPaddingSize16,
                    spacing: KPadding.kPaddingSize8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _AdvancedFilterHideButtonWidget(
                        isDesk: false,
                        textKey: widget.textKey,
                        text: widget.title,
                        onPressed: null,
                        listShow: false,
                      ),
                      CancelChipWidget(
                        widgetKey:
                            KWidgetkeys.screen.discounts.appliedFilterItems,
                        isDesk: false,
                        labelText: widget.value!.value.getTrsnslation(context),
                        onPressed: () {
                          widget.onCancelWidgetPressed(
                            widget.value!.value.uk,
                          );
                        },
                        // width: KSize.kPixel160,
                      ),
                    ],
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: _AdvancedFilterHideButtonWidget(
                      isDesk: widget.isDesk,
                      textKey: widget.textKey,
                      text: widget.title,
                      onPressed: () => setState(
                        () => listShow = !listShow,
                      ),
                      listShow: listShow,
                    ),
                  ),
          ),
          if ((widget.value == null || widget.isDesk) && listShow) widget.list,
        ],
      ),
    );
  }
}

class _AdvancedFilterHideButtonWidget extends StatelessWidget {
  const _AdvancedFilterHideButtonWidget({
    required this.isDesk,
    required this.textKey,
    required this.text,
    required this.onPressed,
    required this.listShow,
  });
  final bool isDesk;
  final Key textKey;
  final String text;
  final void Function()? onPressed;
  final bool listShow;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Padding(
        padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
        child: Text(
          text,
          key: textKey,
          style: onPressed == null
              ? textStyle.copyWith(
                  color: AppColors.materialThemeKeyColorsNeutralVariant,
                )
              : textStyle,
        ),
      ),
      iconAlignment: IconAlignment.end,
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.only(
            left: KPadding.kPaddingSize8,
          ),
        ),
      ),
      onPressed: onPressed,
      icon: IconWidget(
        icon: listShow ? KIcon.minus : KIcon.plus,
        padding: KPadding.kPaddingSize8,
        background: isDesk
            ? AppColors.materialThemeKeyColorsNeutral
            : AppColors.materialThemeWhite,
      ),
    );
  }

  TextStyle get textStyle => isDesk
      ? AppTextStyle.materialThemeTitleLarge
      : AppTextStyle.materialThemeTitleMedium;
}
