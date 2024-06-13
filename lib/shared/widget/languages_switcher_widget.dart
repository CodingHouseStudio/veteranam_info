import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class LanguagesSwitcherWidget extends StatelessWidget {
  const LanguagesSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      key: KWidgetkeys.widget.languageSwitcher.widget,
      child: Container(
        decoration: KWidgetTheme.boxDecorationCircular,
        padding: const EdgeInsets.all(
          KPadding.kPaddingSize12,
        ),
        child: Text(
          context.read<AuthenticationBloc>().state.userSetting.locale.text,
          key: KWidgetkeys.widget.languageSwitcher.text,
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
            key: KWidgetkeys.widget.languageSwitcher.item,
            value: languages.elementAt(index).text,
            enabled: languages.elementAt(index) !=
                context.read<AuthenticationBloc>().state.userSetting.locale,
            child: Text(languages.elementAt(index).text),
          );
        }).toList();
      },
    );
  }
}
