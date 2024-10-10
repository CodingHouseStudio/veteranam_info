import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/pw_reset_email/pw_reset_email.dart';
import 'package:veteranam/shared/shared.dart';

class PwResetEmailButtonsWidget extends StatefulWidget {
  const PwResetEmailButtonsWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  State<PwResetEmailButtonsWidget> createState() =>
      _PwResetEmailButtonsWidgetState();
}

class _PwResetEmailButtonsWidgetState extends State<PwResetEmailButtonsWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<PwResetEmailBloc>().state.formState.isSended) {
      return const PwResetEmailResendWidget();
    } else {
      return Column(
        children: [
          Padding(
            padding: widget.isDesk
                ? const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize24,
                  )
                : EdgeInsets.zero,
            child: TextFieldWidget(
              widgetKey: KWidgetkeys.screen.pwResetEmail.emailField,
              onChanged: (text) => context
                  .read<PwResetEmailBloc>()
                  .add(PwResetEmailEvent.emailUpdated(text)),
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
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox16,
          Padding(
            padding: widget.isDesk
                ? const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize24,
                  )
                : EdgeInsets.zero,
            child: Align(
              alignment: Alignment.centerLeft,
              child: DoubleButtonWidget(
                widgetKey: KWidgetkeys.screen.pwResetEmail.sendButton,
                text: context.l10n.next,
                onPressed: () => context.read<PwResetEmailBloc>().add(
                      const PwResetEmailEvent.sendResetCode(),
                    ),
                isDesk: widget.isDesk,
                color: AppColors.materialThemeKeyColorsSecondary,
                textColor: AppColors.materialThemeWhite,
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
