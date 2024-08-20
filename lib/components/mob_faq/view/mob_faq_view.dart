import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class MobFaqScreen extends StatelessWidget {
  const MobFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobFaqBlocprovider(
      key: KWidgetkeys.screen.mobFaq.screen,
      childWidget: const MobFaqBodyWidget(),
    );
  }
}
