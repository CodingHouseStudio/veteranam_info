import 'package:flutter/material.dart';

import 'package:veteranam/components/story/story.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryBlocprovider(
      childWidget: StoryBodyWidget(key: StoryKeys.screen),
    );
  }
}
