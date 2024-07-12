import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class StoryAddScreen extends StatelessWidget {
  const StoryAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoryAddBlocprovider(
      key: KWidgetkeys.screen.storyAdd.screen,
      childWidget: const StoryAddBody(),
    );
  }
}
