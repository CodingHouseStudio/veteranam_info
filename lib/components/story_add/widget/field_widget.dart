part of 'body/story_add_body.dart';

Widget _imageWidget(BuildContext context) {
  if (context.read<StoryAddBloc>().state.image.value != null) {
    return InkWell(
      key: KWidgetkeys.screen.storyAdd.photoButton,
      onTap: () =>
          context.read<StoryAddBloc>().add(const StoryAddEvent.imageUpdated()),
      child: DecoratedBox(
        decoration: KWidgetTheme.boxDecorationImage,
        child: CachedNetworkImage(
          key: KWidgetkeys.widget.cardAddImage.widget,
          imageUrl: context.read<StoryAddBloc>().state.image.value!.path,
          placeholder: (context, url) =>
              const CircularProgressIndicator.adaptive(), //Image.asset(''),
          errorWidget: (context, url, error) {
            debugPrint('image error: $error');
            return KIcon.error;
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  } else {
    return IconButton(
      key: KWidgetkeys.screen.storyAdd.photoButton,
      style: KButtonStyles.imageButton,
      icon: KIcon.addImage,
      onPressed: () =>
          context.read<StoryAddBloc>().add(const StoryAddEvent.imageUpdated()),
    );
  }
}

Widget _message({
  required BuildContext context,
  required bool isDesk,
}) =>
    MessageFieldWidget(
      key: KWidgetkeys.screen.storyAdd.storyField,
      changeMessage: (text) => context.read<StoryAddBloc>().add(
            StoryAddEvent.storyUpdated(text),
          ),
      hintText: context.l10n.writeYourStory,
      isDesk: isDesk,
      errorText: context.read<StoryAddBloc>().state.formStatus ==
              FormzSubmissionStatus.failure
          ? context.read<StoryAddBloc>().state.story.error.value(context)
          : null,
    );
