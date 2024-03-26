import 'package:flutter/material.dart';
import 'package:kozak/components/profile/profile.dart';
import 'package:kozak/shared/shared.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: KWIdgetkeys.profileKeys.screen,
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: const ProfileBodyWidget(),
    );
  }
}
