import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

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
