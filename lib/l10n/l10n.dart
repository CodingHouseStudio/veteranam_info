import 'package:flutter/widgets.dart';
// import 'package:veteranam/l10n/generated/app_localizations.g.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.g.dart';

/// COMMENT: Adds localization in App

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

const locale = AppLocalizations.localizationsDelegates;
const supportedLocales = AppLocalizations.supportedLocales;
