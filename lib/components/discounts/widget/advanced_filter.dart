import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class AdvancedFilterMob extends StatelessWidget {
  const AdvancedFilterMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _AdvanceFilter.button(
      onPressed: () async {
        final bloc = context.read<DiscountWatcherBloc>();
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          barrierColor:
              AppColors.materialThemeKeyColorsSecondary.withOpacity(0.2),
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(KSize.kRadius32)),
          ),
          showDragHandle: true,
          builder: (context) => FractionallySizedBox(
            heightFactor: 0.9,
            child: BlocProvider.value(
              value: bloc,
              child: BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
                builder: (context, state) => Column(
                  children: [
                    // Row(
                    //   children: [
                    //     IconButtonWidget(
                    //       key: KWidgetkeys.screen.discounts.cancelIcon,
                    //       icon: KIcon.close,
                    //       background: AppColors.materialThemeWhite,
                    //       padding: KPadding.kPaddingSize12,
                    //       onPressed: () => context.pop(),
                    //     ),
                    KSizedBox.kHeightSizedBox16,
                    Text(
                      context.l10n.advancedFilter,
                      key: KWidgetkeys.screen.discounts.cancelText,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    //   ],
                    // ),
                    const _ListViewWidget(
                      isDesk: false,
                      maxHeight: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      isDesk: false,
      context: context,
    );
  }
}

class AdvancedFilterDesk extends StatefulWidget {
  const AdvancedFilterDesk({required this.maxHeight, super.key});
  final double maxHeight;

  @override
  State<AdvancedFilterDesk> createState() => _AdvancedFilterDeskState();
}

class _AdvancedFilterDeskState extends State<AdvancedFilterDesk> {
  late bool bodyHiden;

  @override
  void initState() {
    bodyHiden = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: KPadding.kPaddingSize32),
          child: Column(
            children: [
              _AdvanceFilter.button(
                onPressed: () => setState(() {
                  bodyHiden = !bodyHiden;
                }),
                isDesk: true,
                context: context,
                icon: bodyHiden
                    ? KIcon.trailing.copyWith(
                        key: KWidgetkeys
                            .screen.discounts.advancedFilterButtonIcon,
                      )
                    : KIcon.trailingUp.copyWith(
                        key: KWidgetkeys
                            .screen.discounts.advancedFilterButtonIconUp,
                      ),
              ),
              if (!bodyHiden) ...[
                _ListViewWidget(
                  isDesk: true,
                  maxHeight: widget.maxHeight / 2,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

abstract class _AdvanceFilter {
  static Widget button({
    required bool isDesk,
    required void Function() onPressed,
    required BuildContext context,
    Icon? icon,
  }) =>
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          key: KWidgetkeys.screen.discounts.advancedFilterButton,
          style: KButtonStyles.advancedButtonStyle,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDesk)
                Expanded(
                  child: Text(
                    context.l10n.advancedFilter,
                    style: isDesk
                        ? AppTextStyle.materialThemeHeadlineSmall
                        : AppTextStyle.materialThemeTitleMedium,
                  ),
                )
              else
                Text(
                  context.l10n.advancedFilter,
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineSmall
                      : AppTextStyle.materialThemeTitleMedium,
                ),
              if (icon != null) ...[KSizedBox.kWidthSizedBox8, icon],
            ],
          ),
          // KSizedBox.kWidthSizedBox8,
          icon: IconWidget(
            icon: KIcon.tune,
            background: AppColors.materialThemeKeyColorsNeutral,
            padding: isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
          ),
          onPressed: onPressed,
          //if (isDesk) KIcon.meil,
        ),
      );
}

class _ListViewWidget extends StatefulWidget {
  const _ListViewWidget({
    required this.isDesk,
    required this.maxHeight,
  });
  final bool isDesk;
  final double maxHeight;

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<_ListViewWidget> {
  final ScrollController _scrollController = ScrollController();
  late List<bool> openFilter;
  late List<FilterItem> location;

  @override
  void initState() {
    openFilter = [true, false, true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final body = _body;

    return Column(
      key: KWidgetkeys.screen.discounts.advancedFilterList,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: body,
    );
  }

  List<Widget> get _body {
    final filterLocationIndex =
        context.read<DiscountWatcherBloc>().state.filtersLocationIndex;
    final filtersSubcategoriesIndex =
        context.read<DiscountWatcherBloc>().state.filtersSubcategoriesIndex;
    location = context
        .read<DiscountWatcherBloc>()
        .state
        .discountModelItems
        .getLocationFilter(context);
    final subcategory = context
        .read<DiscountWatcherBloc>()
        .state
        .discountModelItems
        .overallItems(
          getFilter: (item) => item.subcategory,
          context: context,
          getUAFilter: (item) => item.subcategoryUA,
        );
    final uniqueFirstLetters = location.extractValues.uniqueFirstLetters;
    return [
      if (widget.isDesk)
        KSizedBox.kHeightSizedBox32
      else
        KSizedBox.kHeightSizedBox24,
      Row(
        children: [
          if (filterLocationIndex.isNotEmpty) ...[
            Expanded(
              child: Text(
                context.l10n.filterApplied,
                key: KWidgetkeys.screen.discounts.appliedFilterText,
                style: widget.isDesk
                    ? AppTextStyle.materialThemeTitleLarge
                    : AppTextStyle.materialThemeTitleMedium,
              ),
            ),
            KSizedBox.kWidthSizedBox4,
          ],
          _resetButton,
        ],
      ),
      if (filterLocationIndex.isNotEmpty) ...[
        ...List.generate(
          filterLocationIndex.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                key: KWidgetkeys.screen.discounts.appliedFilterItems,
                style: KButtonStyles.advancedFilterButtonStyle,
                icon: KIcon.close,
                label: Text(
                  location
                      .elementAt(filterLocationIndex.elementAt(index))
                      .value,
                  style: widget.isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
                onPressed: () => _onChange(
                  context: context,
                  index: filterLocationIndex.elementAt(index),
                ),
              ),
            ),
          ),
        ),
      ],
      KSizedBox.kHeightSizedBox32,
      button(
        index: 0,
        text: context.l10n.discount,
        key: KWidgetkeys.screen.discounts.discountText,
      ),
      if (openFilter.elementAt(0))
        ...List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: CheckPointWidget(
              key: KWidgetkeys.screen.discounts.discountItems,
              onChanged: () => _onChange(context: context, index: index),
              isCheck: _isCheck(
                index: index,
                filterLocationIndex: filterLocationIndex,
              ),
              text: location.elementAt(index).value,
              isDesk: widget.isDesk,
            ),
          ),
        ),
      KSizedBox.kHeightSizedBox32,
      button(
        index: 1,
        text: context.l10n.subcategory,
        key: Key('value'),
      ),
      if (openFilter.elementAt(1))
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxHeight),
          child: ListView.builder(
            itemCount: subcategory.length,
            semanticChildCount: subcategory.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
              child: CheckPointWidget(
                key: KWidgetkeys.screen.discounts.cityItems,
                onChanged: () => context
                    .read<DiscountWatcherBloc>()
                    .add(DiscountWatcherEvent.filterSubcategory(index)),
                isCheck: filtersSubcategoriesIndex.contains(index),
                text: subcategory.elementAt(index).value,
                isDesk: widget.isDesk,
              ),
            ),
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            shrinkWrap: true,
          ),
        ),
      KSizedBox.kHeightSizedBox32,
      button(
        index: 2,
        text: context.l10n.city,
        key: KWidgetkeys.screen.discounts.cityText,
      ),
      if (openFilter.elementAt(2)) ...[
        KSizedBox.kHeightSizedBox16,
        Wrap(
          spacing: KPadding.kPaddingSize8,
          children: List.generate(
            uniqueFirstLetters.length,
            (index) => InkWell(
              onTap: () => _scrollToLetter(uniqueFirstLetters.elementAt(index)),
              child: Text(
                uniqueFirstLetters.elementAt(index).toUpperCase(),
                style: AppTextStyle.materialThemeTitleMediumNeutralVariant70,
              ),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxHeight),
          child: ListView.builder(
            itemCount: location.length,
            semanticChildCount: location.length,
            controller: _scrollController,
            padding: const EdgeInsets.only(right: KPadding.kPaddingSize16),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
                child: CheckPointAmountWidget(
                  key: KWidgetkeys.screen.discounts.cityItems,
                  onChanged: () => _onChange(context: context, index: index),
                  isCheck: _isCheck(
                    index: index,
                    filterLocationIndex: filterLocationIndex,
                  ),
                  filterItem: location.elementAt(index),
                  isDesk: widget.isDesk,
                ),
              );
            },
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            shrinkWrap: true,
          ),
        ),
      ],
    ];
  }

  void _scrollToLetter(String letter) {
    final index =
        location.indexWhere((element) => element.value.startsWith(letter));
    if (index != -1) {
      _scrollController.animateTo(
        index * 48.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget button({
    required int index,
    required String text,
    required Key key,
  }) =>
      TextButton.icon(
        key: key,
        style: KButtonStyles.doubleButtonStyle,
        onPressed: () => setState(() {
          openFilter[index] = !openFilter[index];
        }),
        label: IconWidget(
          icon: openFilter.elementAt(index) ? KIcon.minus : KIcon.plus,
          padding: KPadding.kPaddingSize8,
          background: AppColors.materialThemeKeyColorsNeutral,
        ),
        icon: Text(
          text,
          key: KWidgetkeys.screen.discounts.discountText,
          style: widget.isDesk
              ? AppTextStyle.materialThemeTitleLarge
              : AppTextStyle.materialThemeTitleMedium,
        ),
      );

  static bool _isCheck({
    required int index,
    required List<int>? filterLocationIndex,
  }) =>
      filterLocationIndex != null && filterLocationIndex.contains(index);

  static void _onChange({required int index, required BuildContext context}) =>
      context
          .read<DiscountWatcherBloc>()
          .add(DiscountWatcherEvent.filterLocation(index));

  Widget get _resetButton => Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          key: KWidgetkeys.screen.discounts.advancedFilterResetButton,
          style: KButtonStyles.borderBlackButtonStyle,
          onPressed: () => context
              .read<DiscountWatcherBloc>()
              .add(const DiscountWatcherEvent.filterReset()),
          child: Text(
            context.l10n.resetAll,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ),
      );
}
