import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ErrorBodyWidget extends StatelessWidget {
  const ErrorBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        key: KWidgetkeys.screen.error.button,
        onPressed: () => Config.isUser
            ? Config.isWeb
                ? context.goNamed(KRoute.home.name)
                : context.goNamed(KRoute.settings.name)
            : context.goNamed(
                KRoute.myDiscounts.name,
              ), //KRoute.businessDashboard.name),
        child: Text(context.l10n.errorMessage),
      ),
    );
  }
}
