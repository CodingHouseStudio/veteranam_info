import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class MobSettingsScreen extends StatelessWidget {
  const MobSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobSettingsBodyWidget(key: KWidgetkeys.screen.mobSettings.screen);
  }
}