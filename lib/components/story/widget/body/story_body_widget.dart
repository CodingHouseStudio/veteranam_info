import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/story/story.dart';
import 'package:veteranam/shared/shared.dart';

part '../stories_widget_list.dart';

class StoryBodyWidget extends StatelessWidget {
  const StoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryWatcherBloc, StoryWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () {},
        // I think this event is not necessary for Stream, but
        // I think it's better to give
        // the user imaginary control over it
        // () => context
        // .read<StoryWatcherBloc>()
        // .add(const StoryWatcherEvent.started()),
      ),
      builder: (context, _) {
        return ScaffoldAutoLoadingWidget(
          loadingButtonText: context.l10n.moreStories,
          loadingStatus: _.loadingStatus,
          cardListIsEmpty: _.storyModelItems.isEmpty,
          // loadDataAgain: () => context
          //     .read<StoryWatcherBloc>()
          //     .add(const StoryWatcherEvent.started()),
          titleChildWidgetsFunction: ({required isDesk}) => [
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox16,
            TitleWidget(
              title: context.l10n.stories,
              titleKey: KWidgetkeys.screen.story.title,
              subtitle: context.l10n.storySubtitle,
              subtitleKey: KWidgetkeys.screen.story.subtitle,
              isDesk: isDesk,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
          ],
          mainDeskPadding: ({required maxWidth}) => const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize48,
          ),
          mainChildWidgetsFunction: ({required isDesk}) => [
            SecondaryButtonWidget(
              key: KWidgetkeys.screen.story.seccondaryButton,
              isDesk: isDesk,
              text: context.l10n.addYourStory,
              onPressed: context.read<AuthenticationBloc>().state.status ==
                      AuthenticationStatus.authenticated
                  ? () => context.goNamed(KRoute.storyAdd.name)
                  : null,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            if (!(_.storyModelItems.isEmpty &&
                _.loadingStatus == LoadingStatus.loaded))
              ..._storiesWidgetList(context: context, isDesk: isDesk),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
            // LoadingButton(
            //   widgetKey: KWidgetkeys.screen.story.button,
            //   isDesk: isDesk,
            //   onPressed: () => context.read<StoryWatcherBloc>().add(
            //         const StoryWatcherEvent.loadNextItems(),
            //       ),
            //   text: context.l10n.moreStories,
            // ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
          ],
          loadFunction: () => context.read<StoryWatcherBloc>().add(
                const StoryWatcherEvent.loadNextItems(),
              ),
        );
      },
    );
  }
}
