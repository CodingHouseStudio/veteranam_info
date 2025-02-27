import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/consent_dialog/bloc/consent_dialog_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CookiesDialogWidget extends StatelessWidget {
  const CookiesDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<ConsentDialogBloc>(),
      child: BlocBuilder<AppLayoutBloc, AppLayoutState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  cookiesSnackbarUK,
                  key: DialogsKeys.snackBarText,
                  style: state.appVersionEnum.isTablet
                      ? AppTextStyle.materialThemeBodyLargeNeutral
                      : AppTextStyle.materialThemeBodyMediumNeutral,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<ConsentDialogBloc>().add(
                        const SubmittedConsentEvent(
                          onlyNecessary: true,
                        ),
                      );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Text(
                  context.l10n.acceptNecessary,
                  style: state.appVersionEnum.isTablet
                      ? AppTextStyle.materialThemeBodyLargeNeutral
                      : AppTextStyle.materialThemeBodyMediumNeutral,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<ConsentDialogBloc>().add(
                        const SubmittedConsentEvent(
                          onlyNecessary: false,
                        ),
                      );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                style: KButtonStyles.cookiesAcceptButtonStyle,
                child: Text(
                  context.l10n.accept,
                  style: state.appVersionEnum.isTablet
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

const cookiesSnackbarUK =
    'Сервіс "veteranam" використовує обов\'язкові кукі для безпеки та '
    'стабільної роботи, а також анонімні аналітичні кукі для покращення'
    ' сервісу. Продовжуючи користуватись, ви погоджуєтесь на використання'
    ' всіх типів кукі та нашу політику конфіденційності.';
