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
              children: List.generate(
                Language.values.length,
                (index) => Padding(
                  padding: index == 0
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(left: KPadding.kPaddingSize8),
                  child: _buildLanguageOption(
                    Language.values.elementAt(index).text,
                    Language.values.elementAt(index) ==
                        state.userSetting.locale,
                  ),
                ),
              ),
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
    return Container(
      decoration: isSelected
          ? KWidgetTheme.boxDecorationBlackCircular
          : KWidgetTheme.boxDecorationGrayCircular,
      margin: const EdgeInsets.symmetric(vertical: KPadding.kPaddingSize2),
      padding: const EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize12,
        vertical: KPadding.kPaddingSize8,
      ),
      child: Text(
        languageName,
        key: KWidgetkeys.widget.languageSwitcher.text,
        style: isSelected
            ? AppTextStyle.materialThemeTitleMediumNeutral
            : AppTextStyle.materialThemeTitleMedium,
      ),
    );
  }
}
