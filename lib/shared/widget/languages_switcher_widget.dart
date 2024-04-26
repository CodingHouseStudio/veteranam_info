import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class LanguagesSwitcherWidget extends StatelessWidget {
  const LanguagesSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = LanguageExtension.getAllLanguage;
    return PopupMenuButton<String>(
      key: KWidgetkeys.widget.languageSwitcher.widget,
      child: Container(
        decoration: KWidetTheme.boxDecorationCircular,
        padding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize8,
          vertical: KPadding.kPaddingSize10,
        ),
        child: Text(
          context.l10n.localeName.getLocale.text,
          key: KWidgetkeys.widget.languageSwitcher.text,
          style: AppTextStyle.text24,
        ),
      ),
      onSelected: (value) => context
          .read<AuthenticationBloc>()
          .add(AppLanguageChanged(value.getLocale)),
      itemBuilder: (BuildContext context) {
        return List.generate(languages.length, (index) {
          return PopupMenuItem<String>(
            key: KWidgetkeys.widget.languageSwitcher.item,
            value: languages.elementAt(index).text,
            enabled: languages.elementAt(index).value.languageCode !=
                context.l10n.localeName,
            child: Text(languages.elementAt(index).text),
          );
        }).toList();
      },
    );
  }
}
