import 'package:flutter/widgets.dart';
import 'package:veteranam/generated/l10n.dart';

/// COMMENT: Adds localization in App
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

const locale = AppLocalizations.delegate;
