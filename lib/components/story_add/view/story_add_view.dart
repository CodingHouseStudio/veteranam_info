import 'package:flutter/material.dart';
import 'package:veteranam/components/story_add/story_add.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class StoryAddScreen extends StatelessWidget {
  const StoryAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryAddBlocprovider(
      key: StoryAddKeys.screen,
      childWidget: const StoryAddBody(),
    );
  }
}
