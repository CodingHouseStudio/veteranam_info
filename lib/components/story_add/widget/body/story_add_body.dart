import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class StoryAddBody extends StatelessWidget {
  const StoryAddBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryAddBloc, StoryAddState>(
      listenWhen: (previous, current) =>
          current.formStatus == FormzSubmissionStatus.success,
      listener: (context, state) =>
          context.goNamedWithScroll(KRoute.story.name),
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus ||
          previous.isAnonymously != current.isAnonymously,
      builder: (context, _) {
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk}) => [
            KSizedBox.kHeightSizedBox40,
            ...TitleWidget.titleWidgetList(
              title: context.l10n.stories,
              titleKey: KWidgetkeys.screen.story.title,
              subtitle: context.l10n.storyAddSubtitle,
              subtitleKey: KWidgetkeys.screen.story.subtitle,
              isDesk: isDesk,
            ),
            KSizedBox.kHeightSizedBox56,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize32,
                    ),
                    child: Text(
                      context.l10n.yourStory,
                      style: AppTextStyle.text40,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: MessageFieldWidget(
                    changeMessage: (text) => context.read<StoryAddBloc>().add(
                          StoryAddEvent.storyUpdated(text),
                        ),
                    hintText: context.l10n.writeYourStory,
                    isDesk: isDesk,
                    errorText: context.read<StoryAddBloc>().state.formStatus ==
                            FormzSubmissionStatus.failure
                        ? context
                            .read<StoryAddBloc>()
                            .state
                            .story
                            .error
                            .value(context)
                        : null,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox40,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.addPhoto,
                          style: AppTextStyle.text40,
                        ),
                        Text(
                          context.l10n.notNecessarily,
                          style: AppTextStyle.hint20,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _.image.value != null
                      ? Container(
                          decoration: KWidgetTheme.boxDecorationImage(context),
                          child: CachedNetworkImage(
                            key: KWidgetkeys.widget.cardAddImage.widget,
                            imageUrl: _.image.value!.path,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator
                                    .adaptive(), //Image.asset(''),
                            errorWidget: (context, url, error) {
                              debugPrint('image error: $error');
                              return KIcon.error;
                            },
                            fit: BoxFit.cover,
                          ),
                        )
                      : IconButton(
                          style: KButtonStyles.imageButton(context),
                          icon: KIcon.addImage,
                          onPressed: () => context
                              .read<StoryAddBloc>()
                              .add(const StoryAddEvent.imageUpdated()),
                        ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox40,
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SwitchWidget(
                            isSelected: _.isAnonymously,
                            onChanged: (p0) => context
                                .read<StoryAddBloc>()
                                .add(const StoryAddEvent.anonymouslyUpdated()),
                          ),
                          KSizedBox.kWidthSizedBox16,
                          Expanded(
                            child: Text(
                              context.l10n.publishAnonymously,
                              style: AppTextStyle.text24,
                            ),
                          ),
                        ],
                      ),
                      KSizedBox.kHeightSizedBox16,
                      Text(
                        context.l10n.publishAnonymouslyStorySubtitle,
                        style: AppTextStyle.hint24,
                      ),
                      KSizedBox.kHeightSizedBox40,
                      ButtonWidget(
                        text: context.l10n.publish,
                        isDesk: isDesk,
                        onPressed: () => context
                            .read<StoryAddBloc>()
                            .add(const StoryAddEvent.save()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox56,
          ],
        );
      },
    );
  }
}
