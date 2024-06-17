part of 'body/information_body_widget.dart';

List<Widget> _newsWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading =
      context.read<InformationWatcherBloc>().state.loadingStatus !=
          LoadingStatus.loaded;
  final informationModelItems = isLoading
      ? List.generate(
          KDimensions.shimmerInformationItems,
          (index) => KMockText.informationModel.copyWith(
            id: index.toString(),
          ),
        )
      : context
          .read<InformationWatcherBloc>()
          .state
          .filteredInformationModelItems;
  return List.generate(
      context.read<InformationWatcherBloc>().state.failure == null
          ? informationModelItems.length
          : 0, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize40 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: SkeletonizerWidget(
        isLoading: isLoading,
        child: NewsCardWidget(
          key: index != informationModelItems.length - 1
              ? KWidgetkeys.screen.information.card
              : KWidgetkeys.screen.information.cardLast,
          informationItem: informationModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
