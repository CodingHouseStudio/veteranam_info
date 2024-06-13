import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class LanguagesSwitcherWidgetDesk extends StatefulWidget {
  const LanguagesSwitcherWidgetDesk({super.key});

  @override
  LLanguagesSwitcherWidgetDeskState createState() =>
      LLanguagesSwitcherWidgetDeskState();
}

class LLanguagesSwitcherWidgetDeskState
    extends State<LanguagesSwitcherWidgetDesk> {
  bool isUkrainian = true;

  void _toggleLanguage() {
    setState(() {
      isUkrainian = !isUkrainian;
      final selectedLanguage = isUkrainian ? Language.ukrain : Language.english;
      context
          .read<AuthenticationBloc>()
          .add(AppLanguageChanged(selectedLanguage));
    });
  }

  @override
  Widget build(BuildContext context) {
    final languages = LanguageExtension.getAllLanguage;
    return GestureDetector(
      key: KWidgetkeys.widget.languageSwitcher.widget,
      onTap: _toggleLanguage,
      child: Container(
        decoration: KWidgetTheme.boxDecorationWhite,
        child: Row(
          key: KWidgetkeys.widget.languageSwitcher.item,
          children: [
            _buildLanguageOption(
              languages.first.text,
              isUkrainian,
            ),
            KSizedBox.kWidthSizedBox8,
            _buildLanguageOption(
              languages.last.text,
              !isUkrainian,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, bool isSelected) {
    return Container(
      decoration: isSelected
          ? KWidgetTheme.boxDecorationBlackCircular
          : KWidgetTheme.boxDecorationGrayCircular,
      padding: const EdgeInsets.all(
        KPadding.kPaddingSize8,
      ),
      child: Text(
        language,
        key: KWidgetkeys.widget.languageSwitcher.text,
        style: isSelected
            ? AppTextStyle.materialThemeTitleMediumWhite
            : AppTextStyle.materialThemeTitleMedium,
      ),
    );
  }
}
