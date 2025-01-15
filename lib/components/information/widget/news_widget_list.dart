part of 'body/information_body_widget.dart';

List<Widget> _newsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<InformationModel>(
      loadingStatus: context.read<InformationWatcherBloc>().state.loadingStatus,
      modelItems: context
          .read<InformationWatcherBloc>()
          .state
          .filteredInformationModelItems,
      cardWidget: ({required modelItem, required isLoading}) => NewsCardWidget(
        key: InformationKeys.card,
        informationItem: modelItem,
        isDesk: isDesk,
        onLikeChange: ({required like}) =>
            context.read<InformationWatcherBloc>().add(
                  InformationWatcherEvent.like(
                    informationModel: modelItem,
                    isLiked: like,
                  ),
                ),
        share: '${KRoute.home.path}${KRoute.information.path}/${modelItem.id}',

        // () => context
        //     .read<InformationWatcherBloc>()
        //     .add(const InformationWatcherEvent.getReport()),
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerInformationItems,
      isNotFailure:
          context.read<InformationWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.informationModel,
    );
