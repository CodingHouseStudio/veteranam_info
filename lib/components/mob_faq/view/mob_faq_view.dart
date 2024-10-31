import 'package:flutter/material.dart';
import 'package:veteranam/components/mob_faq/mob_faq.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobFaqScreen extends StatelessWidget {
  const MobFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MobFaqBlocprovider(
        //   key: KWidgetkeys.screen.mobFaq.screen,
        //   childWidget:
        MobFaqBodyWidget(key: KWidgetkeys.screen.mobFaq.screen);
    // );
  }
}
