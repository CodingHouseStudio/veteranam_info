import 'package:flutter/material.dart';
import 'package:veteranam/components/my_story/my_story.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ProfileMyStoryScreen extends StatelessWidget {
  const ProfileMyStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyStoryBlocprovider(
      key: KWidgetkeys.screen.myStory.screen,
      childWidget: const ProfileMyStoryBodyWidget(),
    );
  }
}
