import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/news_card/news_card.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class NewsCardDialog extends StatelessWidget {
  const NewsCardDialog({required this.id, super.key});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutCubit, AppLayoutState>(
      builder: (context, state) {
        return AlertDialog(
          key: NewsCardDialogKeys.dialog,
          shape: KWidgetTheme.outlineBorder,
          insetPadding: const EdgeInsets.all(KPadding.kPaddingSize16),
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.hardEdge,
          scrollable: true,
          content: NewsCardBlocprovider(
            childWidget: NewsCardBody(
              isDesk: state.appVersionEnum.isDesk,
            ),
            id: id,
          ),
        );
      },
    );
  }
}
