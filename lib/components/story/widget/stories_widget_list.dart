part of 'body/story_body_widget.dart';

List<Widget> _storiesWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    cardWidgetList<StoryModel>(
      loadingStatus: context.read<StoryWatcherBloc>().state.loadingStatus,
      modelItems: context.read<StoryWatcherBloc>().state.loadingStoryModelItems,
      cardWidget: ({required modelItem, required isLoading}) => StoryCardWidget(
        key: StoryKeys.card,
        storyModel: modelItem,
        isDesk: isDesk,
      ),
      isDesk: isDesk,
      shimmerItemsNumber: KDimensions.shimmerStoriesItems,
      isNotFailure: context.read<StoryWatcherBloc>().state.failure == null,
      shimmerItem: KMockText.storyModel,
    );
