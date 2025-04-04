import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class NewsCardBody extends StatelessWidget {
  const NewsCardBody({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCardWatcherBloc, NewsCardWatcherState>(
      builder: (context, _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: KMinMaxSize.maxWidth640),
          child: CardEmptyWidget(
            cardIsEmpty: _.failure != null,
            popRouteName: KRoute.information.name,
            chilcWidget: SkeletonizerWidget(
              isLoading: _.loadingStatus != LoadingStatus.loaded,
              child: NewsCardWidget(
                key: NewsCardDialogKeys.widget,
                informationItem:
                    _.informationModel ?? KMockText.informationModel,
                isDesk: isDesk,
                closeWidget: CloseButtonWidget(
                  widgetKey: NewsCardDialogKeys.closeButton,
                  isDesk: isDesk,
                  routeName: KRoute.information.name,
                ),
                share:
                    '${KRoute.home.path}${KRoute.information.path}/${_.informationModel?.id}',
              ),
            ),
          ),
        );
      },
    );
  }
}
