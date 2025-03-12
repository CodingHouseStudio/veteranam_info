import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/mob_authentication_dialog/widget/body/mob_authentication_dialog_body.dart';
import 'package:veteranam/shared/shared_flutter.dart';

enum MobAuthenticationDialogState {
  signUp,
  login,
}

class MobAuthenticationDialog extends StatelessWidget {
  const MobAuthenticationDialog({
    required this.state,
    super.key,
  });
  final MobAuthenticationDialogState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutBloc, AppLayoutState>(
      builder: (context, _) {
        return AlertDialog(
          key: MobAuthenticationDialogKeys.dialog,
          shape: KWidgetTheme.outlineBorder,
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          clipBehavior: Clip.hardEdge,
          iconPadding: const EdgeInsets.only(
            top: KPadding.kPaddingSize24,
            right: KPadding.kPaddingSize24,
            left: KPadding.kPaddingSize24,
          ),
          contentPadding: EdgeInsets.zero,
          content: AuthenticationDialogBody(
            appVersion: _.appVersionEnum,
            state: state,
          ),
        );
      },
    );
  }
}
