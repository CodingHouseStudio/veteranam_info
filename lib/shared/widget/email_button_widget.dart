import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

class EmailButtonWidget extends StatelessWidget {
  const EmailButtonWidget({
    required this.isDesk,
    this.context,
    super.key,
  });
  final bool isDesk;
  final BuildContext? context;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UrlCubit, UrlEnum?>(
      listener: (context, state) {
        context.dialog.showCopyEmailDialog(state?.value(context));
        if (state == UrlEnum.copySucceed) {
          context.read<UrlCubit>().reset();
        }
      },
      child: TextButton.icon(
        key: KWidgetkeys.widget.emailButton.widget,
        style: KButtonStyles.withoutStyle,
        onPressed: () => context.read<UrlCubit>().copy(KAppText.email),
        label: Text(
          key: KWidgetkeys.widget.emailButton.text,
          KAppText.email,
          style: isDesk
              ? AppTextStyle.materialThemeTitleMedium.copyWith(
                  color: AppColors.materialThemeKeyColorsSecondary,
                )
              : AppTextStyle.materialThemeTitleSmall.copyWith(
                  color: AppColors.materialThemeKeyColorsSecondary,
                ),
        ),
        icon: KIcon.copy.copyWith(
          key: KWidgetkeys.widget.emailButton.icon,
        ),
      ),
    );
  }
}
