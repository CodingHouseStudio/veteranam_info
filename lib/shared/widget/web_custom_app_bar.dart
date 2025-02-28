import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/data_provider/firebase_anaytics_cache_controller.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class WebCustomAppBar extends StatelessWidget {
  const WebCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    if (!KTest.isInterationTest &&
        !KTest.isTest &&
        !GetIt.I.get<FirebaseAnalyticsCacheController>().consentDialogShowed) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.dialog.showCookiesDialog(),
      );
    }
    return const SizedBox.shrink();
  }
}
