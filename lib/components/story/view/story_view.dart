import 'package:flutter/material.dart';
import 'package:kozak/components/story/story.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Page'),
      ),
      body: const StoryBodyWidget(),
    );
  }
}
