import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@singleton
class ScreenSizeRepository with WidgetsBindingObserver {
  ScreenSizeRepository() {
    WidgetsBinding.instance.addObserver(this);
  }
  final StreamController<Size> _sizeController =
      StreamController<Size>.broadcast();

  Stream<Size> get sizeStream => _sizeController.stream;

  @override
  void didChangeMetrics() {
    final size = _getScreenSize;
    _sizeController.add(size);
  }

  Size get getCurrentScreenSize {
    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    final view = platformDispatcher.views.first;
    return view.physicalSize / view.devicePixelRatio;
  }

  Size get _getScreenSize {
    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    final view = platformDispatcher.views.first;
    return view.physicalSize / view.devicePixelRatio;
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sizeController.close();
  }
}
