part of 'body/information_body_widget.dart';

List<Widget> _newsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final informationModelItems =
      context.read<InformationWatcherBloc>().state.loadingStatus ==
              LoadingStatus.loaded
          ? context
              .read<InformationWatcherBloc>()
              .state
              .filteredInformationModelItems
          : List.generate(
              KDimensions.shimmerInformationItems,
              (index) => KMockText.informationModel.copyWith(
                id: index.toString(),
              ),
            );
  return List.generate(informationModelItems.length, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize40 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: Skeletonizer(
        enabled: context.read<InformationWatcherBloc>().state.loadingStatus !=
            LoadingStatus.loaded,
        child: NewsCardWidget(
          key: KWidgetkeys.screen.information.card,
          informationItem: informationModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
