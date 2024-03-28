import 'package:flutter/foundation.dart';

final bool isWebMobile = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);
final bool isWebDesktop = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.fuchsia ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows);
