import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryBlocprovider(
      childWidget: StoryBodyWidget(key: KWidgetkeys.screen.story.screen),
    );
  }
}
