import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    required this.isDesk,
    required this.isPassword,
    required this.action,
    required this.buttonKey,
    super.key,
  });
  final bool isDesk;
  final bool isPassword;
  final void Function() action;
  final Key buttonKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkStatus>(
      builder: (context, state) {
        final button = DoubleButtonWidget(
          widgetKey: buttonKey,
          text: isPassword ? context.l10n.register : context.l10n.next,
          onPressed: state.isOffline && isPassword ? null : action,
          isDesk: isDesk,
          color: state.isOffline && isPassword
              ? AppColors.materialThemeRefNeutralVariantNeutralVariant40
              : null,
          textColor: state.isOffline && isPassword
              ? AppColors.materialThemeRefNeutralNeutral90
              : null,
          deskPadding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize64,
            vertical: KPadding.kPaddingSize12,
          ),
          mobTextWidth: double.infinity,
          mobHorizontalTextPadding: KPadding.kPaddingSize60,
          mobVerticalTextPadding: KPadding.kPaddingSize12,
          mobIconPadding: KPadding.kPaddingSize12,
          darkMode: true,
        );

        if (state.isOffline) {
          return Column(
            children: [
              button,
              Padding(
                padding: const EdgeInsets.only(
                  top: KPadding.kPaddingSize4,
                  left: KPadding.kPaddingSize8,
                  right: KPadding.kPaddingSize8,
                  bottom: KPadding.kPaddingSize16,
                ),
                child: Text(
                  context.l10n.networkFailure,
                  style: AppTextStyle.materialThemeBodyMediumError,
                ),
              ),
            ],
          );
        } else {
          return button;
        }
      },
    );
  }
}
