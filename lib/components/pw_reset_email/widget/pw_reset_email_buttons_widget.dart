import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart';
import 'package:veteranam/components/pw_reset_email/pw_reset_email.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class PwResetEmailFormWidget extends StatefulWidget {
  const PwResetEmailFormWidget({
    required this.isDesk,
    required this.email,
    super.key,
  });
  final bool isDesk;
  final String? email;

  @override
  State<PwResetEmailFormWidget> createState() => _PwResetEmailFormWidgetState();
}

class _PwResetEmailFormWidgetState extends State<PwResetEmailFormWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<PwResetEmailBloc>().state.formState.isSended) {
      return const PwResetEmailResendWidget();
    } else {
      return Column(
        spacing:
            widget.isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
        children: [
          Padding(
            padding: widget.isDesk
                ? const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize24,
                  )
                : EdgeInsets.zero,
            child: TextFieldWidget(
              widgetKey: PwResetEmailKeys.emailField,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) => context
                  .read<PwResetEmailBloc>()
                  .add(PwResetEmailEvent.emailUpdated(text)),
              isRequired: true,
              errorText: context
                  .read<PwResetEmailBloc>()
                  .state
                  .email
                  .error
                  .value(context),
              labelText: context.l10n.email,
              isDesk: widget.isDesk,
              controller: controller,
              showErrorText: context.read<PwResetEmailBloc>().state.formState ==
                  PwResetEmailEnum.invalidData,
            ),
          ),
          Padding(
            padding: widget.isDesk
                ? const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize24,
                  )
                : EdgeInsets.zero,
            child: Align(
              alignment: Alignment.centerLeft,
              child: DoubleButtonWidget(
                widgetKey: PwResetEmailKeys.sendButton,
                text: context.l10n.next,
                onPressed: () => context.read<PwResetEmailBloc>().add(
                      const PwResetEmailEvent.sendResetCode(),
                    ),
                isDesk: widget.isDesk,
                // color: AppColors.materialThemeKeyColorsSecondary,
                // textColor: AppColors.materialThemeWhite,
                deskPadding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize64,
                  vertical: KPadding.kPaddingSize12,
                ),
                mobTextWidth: double.infinity,
                mobHorizontalTextPadding: KPadding.kPaddingSize60,
                mobVerticalTextPadding: KPadding.kPaddingSize12,
                mobIconPadding: KPadding.kPaddingSize12,
                darkMode: true,
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
