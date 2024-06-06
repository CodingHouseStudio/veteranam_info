part of 'body/work_employee_body.dart';

List<Widget> worksWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final workModelItems =
      context.read<WorkEmployeeWatcherBloc>().state.workModelItems.isNotEmpty
          ? context.read<WorkEmployeeWatcherBloc>().state.filteredWorkModelItems
          : List.generate(
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
            );
  return List.generate(workModelItems.length, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: Skeletonizer(
        enabled: context.read<WorkEmployeeWatcherBloc>().state.loadingStatus !=
            LoadingStatus.loaded,
        child: WorkCardWidget(
          key: KWidgetkeys.screen.workEmployee.cards,
          firstItemIsFirst: index == 0,
          workModel: workModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
