import 'package:flutter/widgets.dart';
import 'package:veteranam/components/pw_reset_email/pw_reset_email.dart';
import 'package:veteranam/shared/shared.dart';

class PwResetEmailScreen extends StatelessWidget {
  const PwResetEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PwResetEmailBlocprovider(
      childWidget: PwResetEmailBodyWidget(
        key: KWidgetkeys.screen.pwResetEmail.screen,
      ),
    );
  }
}
