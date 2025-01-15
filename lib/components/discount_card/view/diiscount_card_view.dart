import 'package:flutter/material.dart';
import 'package:veteranam/components/discount_card/discount_card.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountCardDialog extends StatelessWidget {
  const DiscountCardDialog({required this.id, super.key});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        return AlertDialog(
          key: DiscountCardDialogKeys.dialog,
          shape: KWidgetTheme.outlineBorder,
          clipBehavior: Clip.hardEdge,
          insetPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          contentPadding: EdgeInsets.zero,
          scrollable: true,
          content: DiscountCardBlocprovider(
            childWidget: DiscountCardBody(
              isDesk: isDesk,
            ),
            id: id,
          ),
        );
      },
    );
  }
}
