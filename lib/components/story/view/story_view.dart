import 'package:flutter/material.dart';
import 'package:kozak/components/story/story.dart';
import 'package:kozak/shared/shared.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWidgetkeys.storyKeys.screen,
      appBar: AppBar(
        title: const Text('Story Page'),
      ),
      body: const StoryBodyWidget(),
    );
  }
}
