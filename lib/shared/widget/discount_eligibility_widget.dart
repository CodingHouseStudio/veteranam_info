import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountEligibilityWidget extends StatelessWidget {
  const DiscountEligibilityWidget({
    required this.eligibility,
    super.key,
  });

  final List<EligibilityEnum> eligibility;

  @override
  Widget build(BuildContext context) {
    if (eligibility.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(
          top: KPadding.kPaddingSize4,
          right: KPadding.kPaddingSize8,
        ),
        child: DiscountEligibilityExpandedWidget(
          key: ValueKey(eligibility),
          eligibility: eligibility,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class DiscountEligibilityExpandedWidget extends StatelessWidget {
  const DiscountEligibilityExpandedWidget({
    required this.eligibility,
    super.key,
  });

  final List<EligibilityEnum> eligibility;

  @override
  Widget build(BuildContext context) {
    final modifiableEligibility = List<EligibilityEnum>.from(eligibility);
    if (modifiableEligibility.first == EligibilityEnum.all) {
      modifiableEligibility
        ..removeAt(0)
        ..addAll([
          EligibilityEnum.veterans,
          EligibilityEnum.combatants,
          EligibilityEnum.militaryPersonnel,
          EligibilityEnum.familyMembersOfTheDeceased,
          EligibilityEnum.personsWithDisabilitiesDueToWar,
          EligibilityEnum.emergencyServiceEmployees,
          EligibilityEnum.policeOfficers,
        ]);
    }

    return Wrap(
      key: KWidgetkeys.widget.cityList.markdownFulllList,
      children: _buildWidgets(
        modifiableEligibility.length > 5
            ? modifiableEligibility.take(5).toList()
            : modifiableEligibility,
        context,
      ),

      // TextSpan(
      //   style: AppTextStyle.materialThemeLabelLarge,
      //   children: _buildTextSpans(
      //     eligibility.length > 5 ? eligibility.take(5).toList()
      // : eligibility,
      //     context,
      //   ),
      // ),
    );
  }

  List<Widget> _buildWidgets(
    List<EligibilityEnum> eligibilityItems,
    BuildContext context,
  ) {
    final widgets = <Widget>[
      ...eligibilityItems.map(
        (eligibilityItem) => Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            eligibilityItem.eligibilityIcon,
            KSizedBox.kWidthSizedBox4,
            Text(
              eligibilityItem.getValue(context),
              style: AppTextStyle.materialThemeLabelMedium,
            ),
            KSizedBox.kWidthSizedBox8,
          ],
        ),
      ),
    ];

    if (eligibility.length > 5) {
      widgets.add(
        TextButton(
          onPressed: null,
          child: Text(
            context.l10n.moreWhomGranted(eligibility.length - 5),
            style: AppTextStyle.materialThemeLabelLargeRef,
          ),
        ),
      );
    }

    return widgets;
  }
}
