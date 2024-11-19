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
        bottomNavigationBar: Config.isWeb
            ? null
            : const MobNavigationWidget(
                index: 0,
              ),
        appBar: AppBar(
          backgroundColor: AppColors.materialThemeWhite,
          toolbarHeight: KSize.kAppBarHeight,
        ),
        body: const FeedbackBodyWidget(),
      ),
    );
    if (Config.isWeb) {
      return scaffold;
    }
    return SafeArea(child: scaffold);
  }
}
