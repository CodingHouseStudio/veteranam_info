import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class StoryBodyWidget extends StatelessWidget {
  const StoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryWatcherBloc, StoryWatcherState>(
      builder: (context, _) {
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk}) {
            final childWidgets = [
              if (isDesk)
                KSizedBox.kHeightSizedBox40
              else
                KSizedBox.kHeightSizedBox16,
              ...TitleWidget.titleWidgetList(
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
              Padding(
                padding: isDesk
                    ? const EdgeInsets.symmetric(
                        horizontal: KPadding.kPaddingSize48,
                      )
                    : EdgeInsets.zero,
                child: SecondartButtonWidget(
                  key: KWidgetkeys.screen.story.seccondaryButton,
                  isDesk: isDesk,
                  text: context.l10n.addYourStory,
                  onPressed: context.read<AuthenticationBloc>().state.status ==
                          AuthenticationStatus.authenticated
                      ? () => context.goNamedWithScroll(KRoute.storyAdd.name)
                      : null,
                ),
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox40
              else
                KSizedBox.kHeightSizedBox24,
            ];

            switch (_.loadingStatus) {
              case LoadingStatus.initial:
                childWidgets.add(const CircularProgressIndicator.adaptive());
              case LoadingStatus.loading:
                childWidgets.add(const CircularProgressIndicator.adaptive());
              case LoadingStatus.loaded:
                if (childWidgets.isNotEmpty) {
                  childWidgets.addAll(
                    [
                      ...List.generate(_.loadingStoryModelItems.length,
                          (index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: index != 0 ? KPadding.kPaddingSize80 : 0,
                          ),
                          child: StoryCardWidget(
                            key: KWidgetkeys.screen.story.card,
                            storyModel:
                                _.loadingStoryModelItems.elementAt(index),
                            isDesk: isDesk,
                          ),
                        );
                      }),
                    ],
                  );
                }

              case LoadingStatus.error:
                childWidgets.add(const CircularProgressIndicator.adaptive());
            }
            return childWidgets
              ..addAll([
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                LoadingButton(
                  key: KWidgetkeys.screen.story.button,
                  isDesk: isDesk,
                  onPressed: () => context.read<StoryWatcherBloc>().add(
                        const StoryWatcherEvent.loadNextItems(),
                      ),
                  iconKey: KWidgetkeys.screen.story.buttonIcon,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
              ]);
          },
        );
      },
    );
  }
}
