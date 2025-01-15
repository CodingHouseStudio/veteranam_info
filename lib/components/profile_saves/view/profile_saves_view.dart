import 'package:flutter/material.dart';
import 'package:veteranam/components/profile_saves/profile_saves.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ProfileSavesScreen extends StatelessWidget {
  const ProfileSavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSavesBody(
      key: ProfileSavesKeys.screen,
    );
  }
}
