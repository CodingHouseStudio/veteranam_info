import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/components/profile_saves/widget/body/profile_saves_body.dart';
import 'package:veteranam/shared/shared.dart';

class ProfileSavesScreen extends StatelessWidget {
  const ProfileSavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscountBlocprovider(
      childWidget: ProfileSavesBody(
        key: KWidgetkeys.screen.profileSaves.screen,
      ),
    );
  }
}
