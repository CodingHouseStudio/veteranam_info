import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountCardBody extends StatelessWidget {
  const DiscountCardBody({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountCardWatcherBloc, DiscountCardWatcherState>(
      builder: (context, _) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: KMinMaxSize.maxWidth640),
        child: CardEmptyWidget(
          cardIsEmpty: _.failure != null,
          popRouteName: KRoute.discounts.name,
          chilcWidget: SkeletonizerWidget(
            isLoading: _.loadingStatus != LoadingStatus.loaded,
            child: DiscountCardWidget(
              key: KWidgetkeys.screen.discountCard.widget,
              isDesk: isDesk,
              discountItem: _.discountModel ?? KMockText.discountModel,
              // reportEvent: null,
              closeWidget: CloseButtonWidget(
                widgetKey: KWidgetkeys.screen.discountCard.closeButton,
                isDesk: isDesk,
                routeName: KRoute.discounts.name,
              ),
              share:
                  '${KRoute.home.path}${KRoute.discounts.path}/${_.discountModel?.id}',

              // isLoading: _.loadingStatus != LoadingStatus.loaded,
              descriptionMethod: (description) => description.replaceAll(
                '- ',
                '‣ ',
              ), // Alert dialog with MarkdownBody widget does not support
              // '-' symbol (I tried several things to fix it but nothing helps)
            ),
          ),
        ),
      ),
    );
  }
}
