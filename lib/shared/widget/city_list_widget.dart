import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CityListWidget extends StatelessWidget {
  const CityListWidget({
    required this.isDesk,
    required this.location,
    required this.subLocation,
    super.key,
  });

  final List<TranslateModel>? location;
  final SubLocation? subLocation;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    final cityList = [
      if (location != null) ...location!,
      if (subLocation != null) ...subLocation!.getCardList(context),
    ];
    return Padding(
      key: ValueKey(cityList),
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize4,
      ),
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
                        cityList.first.getTrsnslation(context),
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
    );
  }
}

class CityWidgetListExpanded extends StatelessWidget {
  const CityWidgetListExpanded({
    required this.cityList,
    required this.isDesk,
    super.key,
  });

  final List<TranslateModel> cityList;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: KWidgetkeys.widget.cityList.markdownFulllList,
      text: TextSpan(
        text: cityList.getCityString(
          context: context,
          showFullText: false,
        ),
        style: AppTextStyle.materialThemeLabelLarge,
        children: [
          // if (isExpanded)
          //   TextSpan(
          //     text: context.l10n.hideExpansion,
          //     style: AppTextStyle.materialThemeLabelLargeRef,
          //     recognizer: TapGestureRecognizer()..onTap,
          //   )
          // else
          TextSpan(
            text: context.l10n.moreCities(
              cityList.length - 1,
            ),
            style: AppTextStyle.materialThemeLabelLargeRef,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //context.goNamed();
              },
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
}
