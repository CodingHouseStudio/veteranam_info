part of 'body/story_body_widget.dart';

List<Widget> _storiesWidgetList({
  required BuildContext context,
  required bool isDesk,
}) {
  final storyModelItems =
      context.read<StoryWatcherBloc>().state.storyModelItems.isNotEmpty
          ? context.read<StoryWatcherBloc>().state.loadingStoryModelItems
          : List.generate(
              KDimensions.shimmerStoriesItems,
              (index) => StoryModel(
                id: index.toString(),
                date: ExtendedDateTime.current,
                story: KMockText.cardData,
                userId: index.toString(),
              ),
            );
  return List.generate(storyModelItems.length, (index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(
              top: isDesk ? KPadding.kPaddingSize80 : KPadding.kPaddingSize24,
            )
          : EdgeInsets.zero,
      child: Skeletonizer(
        enabled: context.read<StoryWatcherBloc>().state.loadingStatus !=
            LoadingStatus.loaded,
        child: StoryCardWidget(
          key: KWidgetkeys.screen.story.card,
          storyModel: storyModelItems.elementAt(index),
          isDesk: isDesk,
        ),
      ),
    );
  });
}
