import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

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
