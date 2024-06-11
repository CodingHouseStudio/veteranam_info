import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class LanguagesSwitcherWidgetMobile extends StatelessWidget {
  const LanguagesSwitcherWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      key: KWidgetkeys.widget.languageSwitcher.widgetMobile,
      child: Container(
        decoration: KWidgetTheme.boxDecorationCircular,
        padding: const EdgeInsets.all(
          KPadding.kPaddingSize12,
        ),
        child: Text(
          context.l10n.localeName.getLocale.text,
          key: KWidgetkeys.widget.languageSwitcher.textMobile,
          style: AppTextStyle.materialThemeTitleMedium,
        ),
      ),
      onSelected: (value) => context
          .read<AuthenticationBloc>()
          .add(AppLanguageChanged(value.getLocale)),
      itemBuilder: (BuildContext context) {
        final languages = LanguageExtension.getAllLanguage;
        return List.generate(languages.length, (index) {
          return PopupMenuItem<String>(
            key: KWidgetkeys.widget.languageSwitcher.itemMobile,
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
