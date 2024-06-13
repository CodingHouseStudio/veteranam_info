part of 'body/story_body_widget.dart';

List<Widget> _storiesWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final isLoading = context.read<StoryWatcherBloc>().state.loadingStatus !=
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
      : context.read<StoryWatcherBloc>().state.loadingStoryModelItems;
  return List.generate(
      context.read<StoryWatcherBloc>().state.failure == null
          ? storyModelItems.length
          : 0, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: Skeletonizer(
        enabled: isLoading,
        child: StoryCardWidget(
          key: KWidgetkeys.screen.story.card,
          storyModel: storyModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
