import 'package:flutter/material.dart';
import 'package:veteranam/components/mob_settings/mob_settings.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobSettingsScreen extends StatelessWidget {
  const MobSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobSettingsBodyWidget(
      key: MobSettingsKeys.screen,
    );
  }
}
