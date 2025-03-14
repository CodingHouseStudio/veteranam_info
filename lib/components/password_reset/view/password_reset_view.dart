import 'package:flutter/widgets.dart';
import 'package:veteranam/components/password_reset/password_reset.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key, this.code, this.continueUrl});
  final String? code;
  final String? continueUrl;

  @override
  Widget build(BuildContext context) {
    return PasswordResetBlocprovider(
      code: code,
      childWidget: PasswordResetBodyWidget(
        key: PasswordResetKeys.screen,
        code: code,
        continueUrl: continueUrl,
      ),
    );
  }
}
