part of 'body/information_body_widget.dart';

List<Widget> _newsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<InformationModel>(
      isLoading: context.read<InformationWatcherBloc>().state.loadingStatus !=
          LoadingStatus.loaded,
      modelItems: context
          .read<InformationWatcherBloc>()
          .state
          .filteredInformationModelItems,
      cardWidget: (modelItem) => NewsCardWidget(
        key: KWidgetkeys.screen.information.card,
        informationItem: modelItem,
        isDesk: isDesk,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerInformationItems,
      isNotFailure:
          context.read<InformationWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.informationModel,
    );
