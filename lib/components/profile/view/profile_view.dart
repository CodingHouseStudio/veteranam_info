import 'package:flutter/material.dart';
import 'package:kozak/components/profile/profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: const ProfileBodyWidget(),
    );
  }
}
