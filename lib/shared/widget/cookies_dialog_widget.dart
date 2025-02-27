import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CookiesDialogWidget extends StatelessWidget {
  const CookiesDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<CookiesDialogCubit>(),
      child: BlocBuilder<AppLayoutBloc, AppLayoutState>(
        builder: (context, state) {
          final textWidget = Text.rich(
            key: DialogsKeys.snackBarText,
            TextSpan(
              text: context.l10n.cookies,
              style: state.appVersionEnum.isDesk
                  ? AppTextStyle.materialThemeBodyLargeNeutral
                  : AppTextStyle.materialThemeBodyMediumNeutral,
              children: [
                TextSpan(
                  text: context.l10n.privacyPolicy2,
                  style: state.appVersionEnum.isDesk
                      ? AppTextStyle.materialThemeBodyLargeNeutralBoldUnderLine
                      : AppTextStyle
                          .materialThemeBodyMediumNeutralBoldUnderLine,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.goNamed(
                          Config.isBusiness
                              ? KRoute.privacyPolicyBusinessCookies.name
                              : KRoute.privacyPolicy.name,
                        ),
                ),
                const TextSpan(
                  text: '.',
                ),
              ],
            ),
          );
          final buttons = [
            TextButton(
              onPressed: () {
                context.read<CookiesDialogCubit>().submitted(
                      onlyNecessary: true,
                    );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text(
                context.l10n.acceptNecessary,
                style: state.appVersionEnum.isDesk
                    ? AppTextStyle.materialThemeBodyLargeNeutral
                    : AppTextStyle.materialThemeBodyMediumNeutral,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<CookiesDialogCubit>().submitted(
                      onlyNecessary: false,
                    );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              style: KButtonStyles.cookiesAcceptButtonStyle,
              child: Text(
                context.l10n.accept,
                style: state.appVersionEnum.isDesk
                    ? AppTextStyle.materialThemeBodyLarge
                    : AppTextStyle.materialThemeBodyMedium,
              ),
            ),
          ];
          if (state.appVersionEnum.isTablet) {
            return Row(
              children: [
                Expanded(
                  child: textWidget,
                ),
                ...buttons,
              ],
            );
          } else {
            return Column(
              children: [
                textWidget,
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: buttons,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
