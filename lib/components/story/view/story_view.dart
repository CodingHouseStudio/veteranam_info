import 'package:flutter/material.dart';
import 'package:veteranam/components/story/story.dart';
import 'package:veteranam/shared/shared.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryBlocprovider(
      childWidget: StoryBodyWidget(key: KWidgetkeys.screen.story.screen),
    );
  }
}
