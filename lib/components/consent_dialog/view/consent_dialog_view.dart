import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/consent_dialog/consent_dialog.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ConsentDialog extends StatelessWidget {
  const ConsentDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutBloc, AppLayoutState>(
      builder: (context, state) {
        return AlertDialog(
          key: PrivacyPolicyDialogKeys.dialog,
          shape: KWidgetTheme.outlineBorder,
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          clipBehavior: Clip.hardEdge,
          iconPadding: const EdgeInsets.only(
            top: KPadding.kPaddingSize24,
            right: KPadding.kPaddingSize24,
            left: KPadding.kPaddingSize24,
          ),
          contentPadding: EdgeInsets.zero,
          content: ConsentDialogBlocprovider(
            child: ConsentDialogBody(
              appVersion: state.appVersionEnum,
            ),
          ),
        );
      },
    );
  }
}
