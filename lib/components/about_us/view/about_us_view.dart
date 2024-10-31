import 'package:flutter/material.dart';
import 'package:veteranam/components/about_us/about_us.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBodyWidget(
      key: KWidgetkeys.screen.aboutUs.screen,
    );
  }
}
