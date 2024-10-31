import 'package:flutter/widgets.dart';
import 'package:veteranam/components/password_reset/password_reset.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key, this.code});
  final String? code;

  @override
  Widget build(BuildContext context) {
    return PasswordResetBlocprovider(
      code: code,
      childWidget: PasswordResetBodyWidget(
        key: KWidgetkeys.screen.passwordReset.screen,
        code: code,
      ),
    );
  }
}
