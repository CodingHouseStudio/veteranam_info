import 'package:flutter/material.dart';
import 'package:kozak/components/profile_saves/widget/body/profile_saves_body.dart';
import 'package:kozak/shared/constants/constants.dart';

class ProfileSavesScreen extends StatelessWidget {
  const ProfileSavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSavesBody(
      key: KWidgetkeys.screen.profileSaves.screen,
    );
  }
}
