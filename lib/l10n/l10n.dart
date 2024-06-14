import 'package:flutter/widgets.dart';
import 'package:kozak/generated/l10n.dart';

/// COMMENT: Adds localization in App
extension AppLocalizationsX on BuildContext {
  S get l10n => S.of(this);
}
