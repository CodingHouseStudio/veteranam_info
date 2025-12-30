import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class EligibilityWidget extends StatelessWidget {
  const EligibilityWidget({
    required this.eligibility,
    required this.isDesk,
    required this.buttonKey,
    super.key,
    this.showFullList = false,
    this.moreButtonEvent,
  });

  final List<EligibilityEnum> eligibility;
  final bool showFullList;
  final bool isDesk;
  final void Function()? moreButtonEvent;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) {
    final itemCount = isDesk ? 5 : 3;
    // if (eligibility.isNotEmpty && eligibility.contains(EligibilityEnum.all))
    {
      //   final modifiableEligibility =
      //       List<EligibilityEnum>.from(EligibilityEnum.valuesWithoutAll);
      //   // return Wrap(
      //   //   key: CityListKeys.markdownFulllList,
      //   //   children: _buildWidgets(
      //   //     modifiableEligibility.length > 5
      //   //         ? modifiableEligibility.take(5).toList()
      //   //         : modifiableEligibility,
      //   //     context,
      //   //   ),
      //   // );
      // }
      // } else {
      //   return Wrap(
      //     key: CityListKeys.markdownFulllList,
      //     children: _buildWidgets(
      //       eligibility.length > 5 ? eligibility.take(5).toList() :
      // eligibility,
      //       context,
      //     ),

      //     // TextSpan(
      //     //   style: AppTextStyle.materialThemeLabelLarge,
      //     //   children: _buildTextSpans(
      //     //     eligibility.length > 5 ? eligibility.take(5).toList()
      //     // : eligibility,
      //     //     context,
      //     //   ),
      //     // ),
      //   );
      // }

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
              list.length > itemCount && !showFullList
                  ? itemCount + 1
                  : list.length,
              (index) {
                if (itemCount > index || showFullList) {
                  final item = list.elementAt(index);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: KPadding.kPaddingSize4,
                    children: [
                      item.eligibilityIcon,
                      Text(
                        item.getValue(context),
                        style: AppTextStyle.materialThemeLabelMedium,
                      ),
                    ],
                  );
                }
                return TextButton(
                  key: buttonKey,
                  onPressed: moreButtonEvent,
                  child: Text(
                    context.l10n.moreWhomGranted(list.length - itemCount),
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
//       key: CityListKeys.markdownFulllList,
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
