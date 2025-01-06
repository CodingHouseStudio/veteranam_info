import 'package:flutter/material.dart';
import 'package:veteranam/components/feedback/feedback.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = FeedbackBlocprovider(
      key: KWidgetkeys.screen.feedback.screen,
      childWidget: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBar,
        body: const FeedbackBodyWidget(),
      ),
    );
    if (Config.isWeb) {
      return scaffold;
    }
    return ColoredBox(
      color: AppColors.materialThemeWhite,
      child: SafeArea(child: scaffold),
    );
  }
}
