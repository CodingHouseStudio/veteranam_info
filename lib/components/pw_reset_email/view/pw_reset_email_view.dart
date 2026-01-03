import 'package:flutter/widgets.dart';
import 'package:veteranam/components/pw_reset_email/pw_reset_email.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class PwResetEmailScreen extends StatelessWidget {
  const PwResetEmailScreen({required this.email, super.key});
  final String? email;

  @override
  Widget build(BuildContext context) {
    return PwResetEmailBlocprovider(
      email: email,
      childWidget: PwResetEmailBodyWidget(
        key: PwResetEmailKeys.screen,
        email: email,
      ),
    );
  }
}
