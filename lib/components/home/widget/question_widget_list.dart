part of 'body/home_body_widget.dart';

List<Widget> _questionWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final questionModelItems =
      context.read<HomeWatcherBloc>().state.questionModelItems.isNotEmpty
          ? context.read<HomeWatcherBloc>().state.questionModelItems
          : List.generate(
              KDimensions.shimmerQuestionItems,
              (index) => QuestionModel(
                id: index.toString(),
                title: KMockText.questionTitle.elementAt(0),
                subtitle: KMockText.questionSubtitle,
              ),
            );
  return List.generate(questionModelItems.length, (index) {
    return Padding(
      padding: index != 0
          ? const EdgeInsets.only(
              top: KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: Skeletonizer(
        enabled: context.read<HomeWatcherBloc>().state.loadingStatus !=
            LoadingStatus.loaded,
        child: QuestionWidget(
          key: KWidgetkeys.screen.home.faq,
          questionModel: questionModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
