import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/information/bloc/information_watcher_bloc.dart';
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
    final selectedFilters =
        context.select((InformationWatcherBloc bloc) => bloc.state.filters);

    return CardTextDetailEvaluateWidget(
      image: informationItem.image,
      text: informationItem.news,
      buttonText: [
        context.l10n.readMore,
        context.l10n.readLess,
      ],
      buttonStyle: KButtonStyles.transparentButtonStyleBottomBorder(context),
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            informationItem.title,
            key: KWidgetkeys.widget.newsCard.title,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
          Text(
            informationItem.date.toLocal().toString().split(' ')[0],
            key: KWidgetkeys.widget.newsCard.date,
            style: AppTextStyle.hint16,
          ),
        ],
      ),
      bottom: selectedFilters != null && selectedFilters.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(
                bottom: KPadding.kPaddingSize16,
                top: KPadding.kPaddingSize24,
              ),
              child: Wrap(
                key: KWidgetkeys.widget.newsCard.tags,
                spacing: KSize.kWrapSpacing8,
                runSpacing: KSize.kWrapRunSpacing4,
                children: selectedFilters.map((tag) {
                  return Container(
                    decoration: KWidgetTheme.boxDecorationWidget(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize4,
                        horizontal: KPadding.kPaddingSize8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tag,
                            style: AppTextStyle.text14,
                          ),
                          KIcon.check,
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          : null,
      isDesk: isDesk,
    );
  }
}
