import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class LanguagesSwitcherWidget extends StatelessWidget {
  const LanguagesSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final isUkrainian = state.userSetting.locale == Language.ukrain;

        return IconButton(
          key: KWidgetkeys.widget.languageSwitcher.widget,
          style: KButtonStyles.boxButtonStyle,
          onPressed: () {
            final selectedLanguage =
                isUkrainian ? Language.english : Language.ukrain;
            context
                .read<AuthenticationBloc>()
                .add(AppLanguageChanged(selectedLanguage));
          },
          icon: Container(
            decoration: KWidgetTheme.boxDecorationWhiteMain,
            child: Row(
              key: KWidgetkeys.widget.languageSwitcher.item,
              children: [
                _buildLanguageOption(
                  Language.ukrain.text,
                  isUkrainian,
                ),
                KSizedBox.kWidthSizedBox8,
                _buildLanguageOption(
                  Language.english.text,
                  !isUkrainian,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language, bool isSelected) {
    return Container(
      decoration: isSelected
          ? KWidgetTheme.boxDecorationBlackCircular
          : KWidgetTheme.boxDecorationGrayCircular,
      padding: const EdgeInsets.all(KPadding.kPaddingSize8),
      child: Text(
        language,
        key: KWidgetkeys.widget.languageSwitcher.text,
        style: isSelected
            ? AppTextStyle.materialThemeTitleMediumNeutral
            : AppTextStyle.materialThemeTitleMedium,
      ),
    );
  }
}
