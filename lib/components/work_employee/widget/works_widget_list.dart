part of 'body/work_employee_body.dart';

List<Widget> worksWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading =
      context.read<WorkEmployeeWatcherBloc>().state.loadingStatus !=
          LoadingStatus.loaded;
  final workModelItems = isLoading
      ? List.generate(
          KDimensions.shimmerWorksItems,
          (index) => WorkModel(
            id: index.toString(),
            title: KMockText.workTitle,
            description: KMockText.workDescription,
            employerContact: KMockText.email,
            price: KMockText.workPrice,
            city: KMockText.workCity,
            companyName: KMockText.workEmployer,
            category: KMockText.workCategory,
          ),
        )
      : context.read<WorkEmployeeWatcherBloc>().state.filteredWorkModelItems;
  return List.generate(
      context.read<WorkEmployeeWatcherBloc>().state.failure == null
          ? workModelItems.length
          : 0, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: SkeletonizerWidget(
        isLoading: isLoading,
        child: WorkCardWidget(
          key: WorkEmployeeKeys.cards,
          firstItemIsFirst: index == 0,
          workModel: workModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
