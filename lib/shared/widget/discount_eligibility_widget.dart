import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class EligibilityWidget extends StatelessWidget {
  const EligibilityWidget({
    required this.eligibility,
    super.key,
    this.showFullList = false,
    this.moreButtonEvent,
  });

  final List<EligibilityEnum> eligibility;
  final bool showFullList;
  final void Function()? moreButtonEvent;

  @override
  Widget build(BuildContext context) {
    if (eligibility.isNotEmpty) {
      final list = eligibility.contains(EligibilityEnum.all)
          ? EligibilityEnum.valuesWithoutAll
          : eligibility;
      return Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize4,
          right: KPadding.kPaddingSize8,
        ),
        child: Wrap(
          key: ValueKey(eligibility),
          runSpacing: KPadding.kPaddingSize12,
          spacing: KPadding.kPaddingSize8,
          children: List.generate(
            list.length > 5 && !showFullList ? 6 : list.length,
            (index) {
              if (5 > index || showFullList) {
                final item = list.elementAt(index);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    item.eligibilityIcon,
                    KSizedBox.kWidthSizedBox4,
                    Text(
                      item.getValue(context),
                      style: AppTextStyle.materialThemeLabelMedium,
                    ),
                  ],
                );
              }
              return TextButton(
                onPressed: moreButtonEvent,
                child: Text(
                  context.l10n.moreWhomGranted(list.length - 5),
                  style: AppTextStyle.materialThemeLabelLargeRef,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

// class DiscountEligibilityExpandedWidget extends StatelessWidget {
//   const DiscountEligibilityExpandedWidget({
//     required this.eligibility,
//     super.key,
//   });

//   final List<EligibilityEnum> eligibility;

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       key: KWidgetkeys.widget.cityList.markdownFulllList,
//       children: _buildWidgets(
//         eligibility.length > 5 ? eligibility.take(5).toList() : eligibility,
//         context,
//       ),

//       // TextSpan(
//       //   style: AppTextStyle.materialThemeLabelLarge,
//       //   children: _buildTextSpans(
//       //     eligibility.length > 5 ? eligibility.take(5).toList()
//       // : eligibility,
//       //     context,
//       //   ),
//       // ),
//     );
//   }

//   // List<Widget> _buildWidgets(
//   //   List<EligibilityEnum> eligibilityItems,
//   //   BuildContext context,
//   // ) {
//   //   final widgets = <Widget>[
//   //     ...eligibilityItems.map(
//   //       (eligibilityItem) => Row(
//   //         mainAxisSize: MainAxisSize.min,
//   //         crossAxisAlignment: CrossAxisAlignment.end,
//   //         children: [
//   //           eligibilityItem.eligibilityIcon,
//   //           KSizedBox.kWidthSizedBox4,
//   //           Text(
//   //             eligibilityItem.getValue(context),
//   //             style: AppTextStyle.materialThemeLabelMedium,
//   //           ),
//   //           KSizedBox.kWidthSizedBox8,
//   //         ],
//   //       ),
//   //     ),
//   //   ];

//   //   if (eligibility.length > 5) {
//   //     widgets.add(
//   //       TextButton(
//   //         onPressed: null,
//   //         child: Text(
//   //           context.l10n.moreWhomGranted(eligibility.length - 5),
//   //           style: AppTextStyle.materialThemeLabelLargeRef,
//   //         ),
//   //       ),
//   //     );
//   //   }

//   //   return widgets;
//   // }
// }
