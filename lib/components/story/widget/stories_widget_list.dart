part of 'body/story_body_widget.dart';

List<Widget> _storiesWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<StoryModel>(
      isLoading: context.read<StoryWatcherBloc>().state.loadingStatus !=
          LoadingStatus.loaded,
      modelItems: context.read<StoryWatcherBloc>().state.loadingStoryModelItems,
      cardWidget: (modelItem) => StoryCardWidget(
        key: KWidgetkeys.screen.story.card,
        storyModel: modelItem,
        isDesk: isDesk,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerStoriesItems,
      isNotFailure: context.read<StoryWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.storyModel,
    );
