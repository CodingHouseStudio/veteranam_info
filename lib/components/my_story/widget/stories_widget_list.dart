part of 'body/my_story_body_widget.dart';

List<Widget> _storiesWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading = context.read<MyStoryWatcherBloc>().state.loadingStatus !=
      LoadingStatus.loaded;
  final storyModelItems = isLoading
      ? List.generate(
          KDimensions.shimmerStoriesItems,
          (index) => StoryModel(
            id: index.toString(),
            date: ExtendedDateTime.current,
            story: KMockText.cardData,
            userId: index.toString(),
          ),
        )
      : context.read<MyStoryWatcherBloc>().state.storyModelItems;
  return List.generate(
      context.read<MyStoryWatcherBloc>().state.failure == null
          ? storyModelItems.length
          : 0, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: SkeletonizerWidget(
        isLoading: isLoading,
        child: StoryCardWidget(
          key: MyStoryKeys.card,
          storyModel: storyModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
