import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class ProfileMyStoryBodyWidget extends StatelessWidget {
  const ProfileMyStoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyStoryWatcherBloc, MyStoryWatcherState>(
      builder: (context, _) => ScaffoldWidget(
        mainChildWidgetsFunction: ({required isDesk}) {
          final childWidgets = [
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            Text(
              context.l10n.myStory,
              key: KWidgetkeys.screen.myStory.title,
              style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
            ),
            KSizedBox.kHeightSizedBox8,
            Text(
              context.l10n.myStoryDetails,
              key: KWidgetkeys.screen.myStory.subtitle,
              style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
          ];
          switch (_) {
            case MyStoryWatcherStateInitial():
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case MyStoryWatcherStateLoading():
              childWidgets.add(const CircularProgressIndicator.adaptive());
            case MyStoryWatcherStateSuccess():
              if (_.storyModelItems.isNotEmpty) {
                childWidgets.addAll([
                  ...List.generate(_.storyModelItems.length, (index) {
                    return Padding(
                      padding: index != 0
                          ? EdgeInsets.only(
                              top: isDesk
                                  ? KPadding.kPaddingSize56
                                  : KPadding.kPaddingSize24,
                            )
                          : EdgeInsets.zero,
                      child: StoryCardWidget(
                        key: KWidgetkeys.screen.myStory.card,
                        storyModel: _.storyModelItems.elementAt(index),
                        isDesk: isDesk,
                        storyPadding: const EdgeInsets.symmetric(
                          horizontal: KPadding.kPaddingSize48,
                        ),
                      ),
                    );
                  }),
                ]);
              }

            case MyStoryWatcherStateFailure():
              childWidgets.add(const CircularProgressIndicator.adaptive());
          }
          return childWidgets
            ..add(
              isDesk
                  ? KSizedBox.kHeightSizedBox56
                  : KSizedBox.kHeightSizedBox24,
            );
        },
      ),
    );
  }
}
