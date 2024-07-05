import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

class LanguagesSwitcherWidget extends StatelessWidget {
  const LanguagesSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return IconButton(
          key: KWidgetkeys.widget.languageSwitcher.widget,
          style: KButtonStyles.boxButtonStyle,
          onPressed: () {
            context.read<AuthenticationBloc>().add(
                  const AppLanguageChanged(),
                );
          },
          icon: Container(
            decoration: KWidgetTheme.boxDecorationWhiteMain,
            child: Row(
              key: KWidgetkeys.widget.languageSwitcher.item,
              children: [
                _buildLanguageOption(
                  Language.ukrain.text,
                  Language.ukrain == state.userSetting.locale,
                ),
                KSizedBox.kWidthSizedBox8,
                _buildLanguageOption(
                  Language.english.text,
                  Language.english == state.userSetting.locale,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    String languageName,
    bool isSelected,
  ) {
    return Column(
      children: [
        KSizedBox.kHeightSizedBox3,
        Container(
          decoration: isSelected
              ? KWidgetTheme.boxDecorationBlackCircular
              : KWidgetTheme.boxDecorationGrayCircular,
          padding: const EdgeInsets.all(KPadding.kPaddingSize8),
          child: Row(
            children: [
              KSizedBox.kWidthSizedBox4,
              Text(
                languageName,
                key: KWidgetkeys.widget.languageSwitcher.text,
                style: isSelected
                    ? AppTextStyle.materialThemeTitleMediumNeutral
                    : AppTextStyle.materialThemeTitleMedium,
              ),
              KSizedBox.kWidthSizedBox4,
            ],
          ),
        ),
        KSizedBox.kHeightSizedBox2,
      ],
    );
  }
}
