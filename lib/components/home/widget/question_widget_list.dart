part of 'body/home_body_widget.dart';

List<Widget> _questionWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading = context.read<HomeWatcherBloc>().state.loadingStatus !=
      LoadingStatus.loaded;
  final questionModelItems = isLoading
      ? List.generate(
          KDimensions.shimmerQuestionItems,
          (index) => KMockText.questionModel.copyWith(
            id: index.toString(),
          ),
        )
      : context.read<HomeWatcherBloc>().state.questionModelItems;
  return List.generate(
      context.read<HomeWatcherBloc>().state.failure == null
          ? questionModelItems.length
          : 0, (index) {
    return Padding(
      padding: index != 0
          ? const EdgeInsets.only(
              top: KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: SkeletonizerWidget(
        isLoading: isLoading,
        child: QuestionWidget(
          key: KWidgetkeys.screen.home.faq,
          questionModel: questionModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
