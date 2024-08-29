import 'package:flutter/foundation.dart';

abstract class KPlatformConstants {
  // static bool get isWebMobile => _isWebMobile;
  // @visibleForTesting
  // static set isWebMobile(bool isWebMobile) => _isWebMobile = isWebMobile;
  static bool get isWebDesktop => _isWebDesktop;
  @visibleForTesting
  static set isWebDesktop(bool isWebDesktop) => _isWebDesktop = isWebDesktop;

  // static bool _isWebMobile = kIsWeb &&
  //     (defaultTargetPlatform == TargetPlatform.android ||
  //         defaultTargetPlatform == TargetPlatform.iOS);
  static bool _isWebDesktop = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.fuchsia ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows);

  static final isWebSaffari = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);
  // static const minWidthThresholdMobile = 800; // Example threshold for mobile
  static const minWidthThresholdDesk = 1024; // Existing threshold for tablet
  static const minWidthThresholdTablet = 768; // Existing threshold for tablet
  static const maxWidthThresholdTablet = 1440; // Existing threshold for tablet
  // static const minWidthThresholdDesktop =
  //     1400; // Existing threshold for desktop
  // static const mobilePaddingKoefficient = 0.25;
  // static const tabletPaddingKoefficient = 3;
  // static const desktopPaddingKoefficient = 4;

  // static bool changeToDescWidget(double screenMaxWidth) {
  //   return screenMaxWidth > KPlatformConstants.minWidthThresholdMobile;
  // }
}
