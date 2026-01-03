import 'package:flutter/material.dart';
import 'package:veteranam/components/profile/profile.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileBlocprovider(
      childWidget: ProfileBodyWidget(
        key: ProfileKeys.screen,
      ),
    );
  }
}
