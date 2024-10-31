import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../buttons_widget_list.dart';
part '../field_widget.dart';
part '../form_widget_list.dart';

class StoryAddBody extends StatelessWidget {
  const StoryAddBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryAddBloc, StoryAddState>(
      listenWhen: (previous, current) =>
          current.formStatus == FormzSubmissionStatus.success ||
          current.failure != null,
      listener: (context, state) {
        if (state.formStatus == FormzSubmissionStatus.success) {
          context.goNamed(KRoute.stories.name);
        }
        context.dialog.showSnackBardTextDialog(
          state.failure?.value(context),
        );
      },
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus ||
          previous.isAnonymously != current.isAnonymously ||
          previous.image != current.image,
      builder: (context, _) {
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            TitleWidget(
              title: context.l10n.stories,
              titleKey: KWidgetkeys.screen.storyAdd.title,
              subtitle: context.l10n.storyAddSubtitle,
              subtitleKey: KWidgetkeys.screen.storyAdd.subtitle,
              isDesk: isDesk,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox32,
            ..._formWidgetList(context: context, isDesk: isDesk),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            ..._buttonsWidgetList(context: context, isDesk: isDesk),
            KSizedBox.kHeightSizedBox56,
          ],
        );
      },
    );
  }
}
