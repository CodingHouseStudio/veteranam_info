import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/my_story/my_story.dart';
import 'package:veteranam/shared/shared.dart';

part '../stories_widget_list.dart';

class ProfileMyStoryBodyWidget extends StatelessWidget {
  const ProfileMyStoryBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyStoryWatcherBloc, MyStoryWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () => context
            .read<MyStoryWatcherBloc>()
            .add(const MyStoryWatcherEvent.started()),
      ),
      builder: (context, _) => ScaffoldWidget(
        titleChildWidgetsFunction: ({required isDesk}) => [
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
        ],
        mainDeskPadding: ({required maxWidth}) =>
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize48),
        mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
          ..._storiesWidgetList(context: context, isDesk: isDesk),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox24,
        ],
      ),
    );
  }
}
