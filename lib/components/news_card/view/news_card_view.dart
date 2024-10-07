import 'package:flutter/material.dart';
import 'package:veteranam/components/news_card/news_card.dart';
import 'package:veteranam/shared/shared.dart';

class NewsCardDialog extends StatelessWidget {
  const NewsCardDialog({required this.id, super.key});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        return AlertDialog(
          key: KWidgetkeys.screen.newsCard.dialog,
          shape: KWidgetTheme.outlineBorder,
          insetPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          contentPadding: EdgeInsets.zero,
          scrollable: true,
          content: NewsCardBlocprovider(
            childWidget: NewsCardBody(
              isDesk: isDesk,
            ),
            id: id,
          ),
        );
      },
    );
  }
}
