import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class ProfileSavesScreen extends StatelessWidget {
  const ProfileSavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSavesBody(
      key: KWidgetkeys.screen.profileSaves.screen,
    );
  }
}
