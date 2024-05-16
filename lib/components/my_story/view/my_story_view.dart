import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class ProfileMyStoryScreen extends StatelessWidget {
  const ProfileMyStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMyStoryBodyWidget(
      key: KWidgetkeys.screen.profile.screen,
    );
  }
}
