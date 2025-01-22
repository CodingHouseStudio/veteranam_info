import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/config/discount_config_cubit.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterListWidget extends StatefulWidget {
  const AdvancedFilterListWidget({
    required this.isDesk,
    required this.list,
    required this.textKey,
    required this.title,
    required this.value,
    required this.onCancelWidgetPressed,
    required this.isLoading,
    super.key,
  });
  final bool isDesk;
  final Widget list;
  final Key textKey;
  final String title;
  final FilterItem? value;
  final void Function(String activeItem) onCancelWidgetPressed;
  final bool isLoading;

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
    return BlocSelector<DiscountConfigCubit, DiscountConfigState, bool>(
      selector: (state) => state.mobFilterEnhancedMobile,
      builder: (context, mobFilterEnhancedMobile) {
        final showList = widget.value == null ||
            widget.isDesk ||
            !mobFilterEnhancedMobile ||
            widget.isLoading;
        return SliverPadding(
          padding: const EdgeInsets.only(
            right: KPadding.kPaddingSize8,
            bottom: KPadding.kPaddingSize8,
          ),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: !showList
                    ? Row(
                        spacing: KPadding.kPaddingSize8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _AdvancedFilterHideButtonWidget(
                            isDesk: false,
                            textKey: widget.textKey,
                            text: widget.title,
                            onPressed: null,
                            listShow: false,
                            showIcon: false,
                          ),
                          Flexible(
                            child: CancelChipWidget(
                              widgetKey: DiscountsFilterKeys.cancelChip,
                              isDesk: false,
                              maxLines: 1,
                              labelText:
                                  widget.value!.value.getTrsnslation(context),
                              onPressed: () {
                                widget.onCancelWidgetPressed(
                                  widget.value!.value.uk,
                                );
                              },
                              // width: KSize.kPixel160,
                            ),
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
              if (showList && listShow) widget.list,
            ],
          ),
        );
      },
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
    this.showIcon = true,
  });
  final bool isDesk;
  final Key textKey;
  final String text;
  final void Function()? onPressed;
  final bool listShow;
  final bool showIcon;

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
      icon: showIcon
          ? IconWidget(
              icon: listShow ? KIcon.minus : KIcon.plus,
              padding: KPadding.kPaddingSize8,
              background: isDesk
                  ? AppColors.materialThemeKeyColorsNeutral
                  : AppColors.materialThemeWhite,
            )
          : null,
    );
  }

  TextStyle get textStyle => isDesk
      ? AppTextStyle.materialThemeTitleLarge
      : AppTextStyle.materialThemeTitleMedium;
}
