import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountCardBody extends StatelessWidget {
  const DiscountCardBody({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountCardWatcherBloc, DiscountCardWatcherState>(
      builder: (context, _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: KMinMaxSize.maxWidth640),
          child: SkeletonizerWidget(
            isLoading: _.loadingStatus != LoadingStatus.loaded,
            child: DiscountCardWidget(
              key: KWidgetkeys.screen.discountCard.widget,
              isDesk: isDesk,
              discountItem: _.discountModel ?? KMockText.discountModel,
              reportEvent: null,
              closeWidget: CloseButtonWidget(
                widgetKey: KWidgetkeys.screen.discountCard.closeButton,
                isDesk: isDesk,
                routeName: KRoute.discounts.name,
              ),
            ),
          ),
        );
      },
    );
  }
}
