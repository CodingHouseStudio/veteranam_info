import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CityListWidget extends StatelessWidget {
  const CityListWidget({
    required this.isDesk,
    required this.location,
    required this.locationEN,
    required this.subLocation,
    super.key,
  });

  final List<String>? location;
  final List<String>? locationEN;
  final SubLocation? subLocation;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    final cityList = [
      if (location != null)
        ...location!.getTrnslation(en: locationEN, context: context),
      if (subLocation != null) ...subLocation!.getCardList(context),
    ];
    return Align(
      key: ValueKey(cityList),
      alignment: isDesk ? Alignment.centerRight : Alignment.centerLeft,
      child: DecoratedBox(
        decoration: KWidgetTheme.boxDecorationWhiteMain,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize8,
            vertical: KPadding.kPaddingSize4,
          ),
          child: IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KIcon.distance.copyWith(
                  key: KWidgetkeys.widget.cityList.icon,
                ),
                KSizedBox.kWidthSizedBox8,
                if (cityList.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: KPadding.kPaddingSize2,
                        right: KPadding.kPaddingSize5,
                      ),
                      child: cityList.length == 1
                          ? Text(
                              cityList.first,
                              key: KWidgetkeys.widget.cityList.text,
                              style: AppTextStyle.materialThemeLabelLarge,
                            )
                          : CityWidgetListExpanded(
                              key: ValueKey(cityList),
                              cityList: cityList,
                              isDesk: isDesk,
                            ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CityWidgetListExpanded extends StatefulWidget {
  const CityWidgetListExpanded({
    required this.cityList,
    required this.isDesk,
    super.key,
  });

  final List<String> cityList;
  final bool isDesk;

  @override
  State<CityWidgetListExpanded> createState() => _CityWidgetListExpandedState();
}

class _CityWidgetListExpandedState extends State<CityWidgetListExpanded> {
  bool isExpanded = false;
  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: isExpanded
          ? KWidgetkeys.widget.cityList.markdownFulllList
          : KWidgetkeys.widget.cityList.markdown,
      text: TextSpan(
        text: '${widget.cityList.getCityString(
          showFullText: isExpanded,
        )} ',
        style: AppTextStyle.materialThemeLabelLarge,
        children: [
          if (isExpanded)
            TextSpan(
              text: context.l10n.hideExpansion,
              style: AppTextStyle.materialThemeLabelLargeRef,
              recognizer: _textSpanEvent,
            )
          else
            TextSpan(
              text: context.l10n.moreCities(
                widget.cityList.length - 1,
              ),
              style: AppTextStyle.materialThemeLabelLargeRef,
              recognizer: _textSpanEvent,
            ),
        ],
      ),
    );
    // return MarkdownBody(
    //   key: isExpanded
    //       ? KWidgetkeys.widget.cityList.markdownFulllList
    //       : KWidgetkeys.widget.cityList.markdown,
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

  GestureRecognizer get _textSpanEvent =>
      TapGestureRecognizer()..onTap = _expandedChangeEvent;
  void _expandedChangeEvent() => setState(() {
        isExpanded = !isExpanded;
      });
}
