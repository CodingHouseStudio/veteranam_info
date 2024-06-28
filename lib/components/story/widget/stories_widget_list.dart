part of 'body/story_body_widget.dart';

List<Widget> _storiesWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<StoryModel>(
      isLoading: context.read<StoryWatcherBloc>().state.loadingStatus !=
          LoadingStatus.loaded,
      modelItems: context.read<StoryWatcherBloc>().state.loadingStoryModelItems,
      cardWidget: ({required modelItem, required key}) => StoryCardWidget(
        key: key,
        storyModel: modelItem,
        isDesk: isDesk,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerStoriesItems,
      cardKey: KWidgetkeys.screen.story.card,
      cardLastKey: KWidgetkeys.screen.story.cardLast,
      isNotFailure: context.read<StoryWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.storyModel,
    );
