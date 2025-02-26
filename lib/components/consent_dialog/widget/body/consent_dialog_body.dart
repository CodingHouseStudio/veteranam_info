import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/consent_dialog/consent_dialog.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ConsentDialogBody extends StatelessWidget {
  const ConsentDialogBody({
    required this.appVersion,
    super.key,
  });

  final AppVersionEnum appVersion;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<ConsentDialogBloc, ConsentDialogState>(
        listener: (context, state) {
          if (state.sent) {
            if (context.canPop()) {
              context.popDialog();
            } else {
              context.goNamed(KRoute.home.name);
            }
          }
        },
        builder: (context, state) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: KMinMaxSize.maxWidth600,
              minWidth: KMinMaxSize.maxWidth600,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: KPadding.kPaddingSize24,
                top: KPadding.kPaddingSize16,
                right: KPadding.kPaddingSize24,
                left: KPadding.kPaddingSize24,
              ),
              child: Column(
                spacing: KPadding.kPaddingSize16,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        ...List.generate(
                          (context.isEnglish ? cookiesEN : cookiesUK).length,
                          (index) {
                            final textArray =
                                context.isEnglish ? cookiesEN : cookiesUK;
                            if (index.isOdd) {
                              return TextSpan(
                                text: textArray.elementAt(index),
                                style: appVersion.isTablet
                                    ? AppTextStyle.materialThemeBodyLargeBold
                                    : AppTextStyle.materialThemeBodyMediumBold,
                              );
                            } else {
                              return TextSpan(
                                text: textArray.elementAt(index),
                              );
                            }
                          },
                        ),
                        TextSpan(
                          text: context.l10n.privacyPolicy2,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                context.goNamed(KRoute.privacyPolicy.name),
                          style: appVersion.isTablet
                              ? AppTextStyle.materialThemeBodyLargeBoldUnderLine
                              : AppTextStyle
                                  .materialThemeBodyMediumBoldUnderLine,
                        ),
                        const TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                    style: appVersion.isTablet
                        ? AppTextStyle.materialThemeBodyLarge
                        : AppTextStyle.materialThemeBodyMedium,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: KPadding.kPaddingSize24,
                      runSpacing: KPadding.kPaddingSize16,
                      alignment: WrapAlignment.spaceBetween,
                      children: appVersion.isTablet
                          ? [
                              unconfirmButton(context),
                              confirmButton(context),
                            ]
                          : [
                              confirmButton(context),
                              unconfirmButton(context),
                            ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget confirmButton(BuildContext context) {
    return DoubleButtonWidget(
      widgetKey: const Key('test'),
      text: context.l10n.accept,
      color: AppColors.materialThemeKeyColorsPrimary,
      isDesk: appVersion.isTablet,
      mobPadding: const EdgeInsets.only(
        top: KPadding.kPaddingSize12,
        bottom: KPadding.kPaddingSize12,
        right: KPadding.kPaddingSize8,
        // left: KPadding.kPaddingSize32,
      ),
      mobIconPadding: KPadding.kPaddingSize12,
      onPressed: () => context.read<ConsentDialogBloc>().add(
            const SubmittedConsentEvent(
              onlyNecessary: false,
            ),
          ),
      hasAlign: !appVersion.isTablet,
      align: Alignment.center,
      mobTextWidth: double.infinity,
    );
  }

  Widget unconfirmButton(BuildContext context) {
    return SecondaryButtonWidget(
      widgetKey: const Key('temporary'),
      onPressed: () => context.read<ConsentDialogBloc>().add(
            const SubmittedConsentEvent(
              onlyNecessary: true,
            ),
          ),
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize8,
      ),
      isDesk: appVersion.isTablet,
      text: context.l10n.acceptNecessary,
      hasAlign: !appVersion.isTablet,
      align: Alignment.center,
      expanded: !appVersion.isTablet,
    );
  }
}

// Every second string is bold
const cookiesUK = [
  'Сервіс "veteranam" використовує ',
  "обов'язкові кукі",
  ' для стабільної та безпечної роботи. ',
  'Ці кукі потрібні для:\n',
  '\t- Захисту від ',
  'зловмисних дій\n',
  '\t- Вашої авторизації та ',
  'збереження сесії\n',
  '\t- Збереження ',
  'ваших налаштувань\n',
  '\nДля ',
  'покращення сервісу',
  ' ми також використовуємо ',
  'аналітичні кукі які є повністю анонімними.',
  '\nВони допомагають нам:\n\t- Виявляти ',
  'помилки\n',
  '\t- Робити сервіс ',
  'зручнішим\n',
  // ignore: lines_longer_than_80_chars
  '\t- Зрозуміти, як ви використовуєте сервіс\n\nПродовжуючи користуватись "veteranam", ви погоджуєтесь на використання ',
  'всіх типів кукі',
  ' та на нашу ',
];
// Every second string is bold
const cookiesEN = [
  'The "veteranam" service uses ',
  'essential cookies',
  ' for stable and secure operation. ',
  'These cookies are necessary for:\n',
  '\t- Protection against ',
  'malicious activities\n',
  '\t- Your authentication and ',
  'session retention\n',
  '\t- Saving ',
  'your preferences\n',
  '\nFor ',
  'service improvement',
  ', we also use ',
  'anonymous analytics cookies.',
  '\nThey help us:\n\t- Detect ',
  'errors\n',
  '\t- Make the service ',
  'more user-friendly\n',
  // ignore: lines_longer_than_80_chars
  '\t- Understand how you use the service\n\nBy continuing to use "veteranam", you agree to the use of ',
  'all types of cookies',
  ' and our ',
];
