import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class LanguagesSwitcherWidget extends StatelessWidget {
  const LanguagesSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      context.l10n.ukrain,
      context.l10n.english,
    ];
    return PopupMenuButton<String>(
      key: KWidgetkeys.widget.languageSwitcher.widget,
      icon: Row(
        children: [
          Text(
            context.l10n.language,
            key: KWidgetkeys.widget.languageSwitcher.text,
          ),
          KIcon.trailing,
        ],
      ),
      onSelected: (value) => context
          .read<LanguageCubit>()
          .changeLanguage(languages.indexOf(value)),
      itemBuilder: (BuildContext context) {
        return List.generate(languages.length, (index) {
          return PopupMenuItem<String>(
            key: KWidgetkeys.widget.languageSwitcher.item,
            value: languages.elementAt(index),
            enabled: index.getLocaleUseIndex.value.languageCode !=
                context.l10n.localeName,
            child: ListTile(
              title: Text(languages.elementAt(index)),
            ),
          );
        }).toList();
      },
    );
  }
}
