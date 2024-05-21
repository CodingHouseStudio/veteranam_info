import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class StoryAddImageWidget extends StatelessWidget {
  const StoryAddImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<StoryAddBloc>().state.image.value != null) {
      return InkWell(
        key: KWidgetkeys.screen.storyAdd.photoButton,
        onTap: () => context
            .read<StoryAddBloc>()
            .add(const StoryAddEvent.imageUpdated()),
        child: Container(
          decoration: context.widgetTheme.boxDecorationImage,
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
        style: context.buttonStyle.imageButton,
        icon: KIcon.addImage,
        onPressed: () => context
            .read<StoryAddBloc>()
            .add(const StoryAddEvent.imageUpdated()),
      );
    }
  }
}
