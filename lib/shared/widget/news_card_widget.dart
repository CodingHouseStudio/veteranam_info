import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    required this.informationItem,
    required this.isDesk,
    super.key,
  });

  final InformationModel informationItem;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return CardTextDetailEvaluateWidget(
      bottom: Padding(
        padding: const EdgeInsets.only(
          bottom: KPadding.kPaddingSize8,
          top: KPadding.kPaddingSize16,
        ),
        child: Wrap(
          key: KWidgetkeys.widget.newsCard.tags,
          spacing: KSize.kWrapSpacing8,
          runSpacing: KSize.kWrapRunSpacing4,
          children:
              (context.read<AuthenticationBloc>().state.userSetting.locale ==
                          Language.english
                      ? informationItem.category
                      : informationItem.categoryUA)
                  .map((category) {
            return Container(
              decoration: KWidgetTheme.boxDecorationCardGrayBorder,
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize4,
                horizontal: KPadding.kPaddingSize8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    category,
                    style: AppTextStyle.materialThemeLabelLarge,
                  ),
                  KIcon.check,
                ],
              ),
            );
          }).toList(),
        ),
      ),
      isDesk: isDesk,
    );
  }
}
