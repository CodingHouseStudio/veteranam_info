import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CityListWidget extends StatelessWidget {
  const CityListWidget({
    required this.isDesk,
    required this.location,
    required this.subLocation,
    required this.buttonKey,
    super.key,
    this.showFullText = false,
    this.moreButtonEvent,
  });

  final List<TranslateModel>? location;
  final SubLocation? subLocation;
  final bool isDesk;
  final bool showFullText;
  final void Function()? moreButtonEvent;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) {
    final cityList = [
      if (location != null) ...location!,
      if (subLocation != null) ...subLocation!.getCardList(context),
    ];
    return Row(
      key: ValueKey(cityList),
      mainAxisSize: MainAxisSize.min,
      spacing: KPadding.kPaddingSize8,
      children: [
        KIcon.location.copyWith(
          key: CityListKeys.icon,
        ),
        if (cityList.isNotEmpty)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: KPadding.kPaddingSize2,
                right: KPadding.kPaddingSize5,
              ),
              child: cityList.length == 1 || showFullText
                  ? Text(
                      cityList.getCityString(
                        showFullText: showFullText,
                        context: context,
                      ),
                      key: CityListKeys.text,
                      style: AppTextStyle.materialThemeLabelLarge,
                    )
                  : _CityWidgetListExpanded(
                      key: ValueKey(cityList),
                      cityList: cityList,
                      isDesk: isDesk,
                      moreButtonEvent: moreButtonEvent,
                      buttonKey: buttonKey,
                    ),
            ),
          ),
      ],
    );
  }
}

class _CityWidgetListExpanded extends StatelessWidget {
  const _CityWidgetListExpanded({
    required this.cityList,
    required this.isDesk,
    required this.buttonKey,
    super.key,
    this.moreButtonEvent,
  });

  final List<TranslateModel> cityList;
  final bool isDesk;
  final void Function()? moreButtonEvent;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      key: CityListKeys.markdownFulllList,
      // mainAxisSize: MainAxisSize.min,
      runSpacing: KPadding.kPaddingSize8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          cityList.getCityString(
            context: context,
            showFullText: false,
          ),
          style: AppTextStyle.materialThemeLabelLarge,
        ),
        TextButton(
          key: buttonKey,
          onPressed: moreButtonEvent,
          child: Text(
            context.l10n.moreCities(
              cityList.length - 1,
            ),
            style: AppTextStyle.materialThemeLabelLargeRef,
          ),
        ),
      ],
    );

    // RichText(
    //   key: CityListKeys.markdownFulllList,
    //   text: TextSpan(
    //     text: cityList.getCityString(
    //       context: context,
    //       showFullText: false,
    //     ),
    //     style: AppTextStyle.materialThemeLabelLarge,
    //     children: [
    //       // if (isExpanded)
    //       //   TextSpan(
    //       //     text: context.l10n.hideExpansion,
    //       //     style: AppTextStyle.materialThemeLabelLargeRef,
    //       //     recognizer: TapGestureRecognizer()..onTap,
    //       //   )
    //       // else
    //       TextSpan(
    //         text: context.l10n.moreCities(
    //           cityList.length - 1,
    //         ),
    //         style: AppTextStyle.materialThemeLabelLargeRef,
    //         recognizer: TapGestureRecognizer()
    //           ..onTap = () {
    //             //context.goNamed();
    //           },
    //       ),
    //     ],
    //   ),
    // );
    // return MarkdownBody(
    //   key: isExpanded
    //       ? CityListKeys.markdownFulllList
    //       : CityListKeys.markdown,
    //   data: widget.cityList
    //       .getCityList(showFullText: !isExpanded, context: context),
    //   onTapLink: (text, href, title) => setState(() {
    //     isExpanded = !isExpanded;
    //   }),
    //   styleSheet: MarkdownStyleSheet(
    //     a: AppTextStyle.materialThemeLabelLargeRef,
    //     p: AppTextStyle.materialThemeLabelLarge,
    //   ),
    // );
  }
}
