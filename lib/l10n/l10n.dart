import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// COMMENT: Adds localization in App

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

const locale = AppLocalizations.localizationsDelegates;
const supportedLocales = AppLocalizations.supportedLocales;
