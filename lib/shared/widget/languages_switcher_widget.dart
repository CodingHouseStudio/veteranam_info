import 'package:flutter/material.dart';
import 'package:kozak/app.dart';
import 'package:kozak/l10n/l10n.dart';
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
      key: KWidgetkeys.widget.filter.popupMenu,
      icon: Row(
        children: [
          Text(
            context.l10n.language,
          ),
          KIcon.trailing,
        ],
      ),
      onSelected: (value) => App.setLocale(
        context,
        Locale(getLocaleName(languages.indexOf(value))),
      ),
      itemBuilder: (BuildContext context) {
        return List.generate(languages.length, (index) {
          return PopupMenuItem<String>(
            key: KWidgetkeys.widget.filter.popupMenuResetAll,
            value: languages.elementAt(index),
            enabled: getLocaleName(index) != context.l10n.localeName,
            child: ListTile(
              title: Text(languages.elementAt(index)),
            ),
          );
        }).toList();
      },
    );
  }

  String getLocaleName(int laguageIndex) {
    switch (laguageIndex) {
      case 0:
        return 'uk';
      case 1:
        return 'en';
      default:
        return 'uk';
    }
  }
}
