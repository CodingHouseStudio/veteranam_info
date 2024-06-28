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
      cardWidget: ({required modelItem, required key}) => NewsCardWidget(
        key: key,
        informationItem: modelItem,
        isDesk: isDesk,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerInformationItems,
      cardKey: KWidgetkeys.screen.information.card,
      cardLastKey: KWidgetkeys.screen.information.cardLast,
      isNotFailure:
          context.read<InformationWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.informationModel,
    );
