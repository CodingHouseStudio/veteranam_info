import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IAppLayoutRepository)
class AppLayoutRepository
    with WidgetsBindingObserver
    implements IAppLayoutRepository {
  AppLayoutRepository()
      : _widgetsBinding = WidgetsBinding.instance,
        _flutterView =
            WidgetsBinding.instance.platformDispatcher.views.elementAtOrNull(0),
        _appVersionController = StreamController<AppVersionEnum>.broadcast() {
    _widgetsBinding.addObserver(this);
  }

  final WidgetsBinding _widgetsBinding;
  FlutterView? _flutterView;
  final StreamController<AppVersionEnum> _appVersionController;

  AppVersionEnum? _lastValue;

  @override
  Stream<AppVersionEnum> get sizeStream => _appVersionController.stream;

  @override
  void didChangeMetrics() {
    final size = _getScreenSize;

    if (size != null) {
      final appVersionEnum = size.appVersionEnum;
      if (_lastValue != appVersionEnum) {
        _appVersionController.add(appVersionEnum);
      }
      _lastValue = appVersionEnum;
    }
    super.didChangeMetrics();
  }

  @override
  AppVersionEnum get getCurrentAppVersion =>
      _getScreenSize?.appVersionEnum ?? AppVersionEnum.mobile;

  Size? get _getScreenSize {
    if (_flutterView == null) {
      final views = _widgetsBinding.platformDispatcher.views;
      _flutterView = views.elementAtOrNull(0);
    }
    if (_flutterView != null) {
      return _flutterView!.physicalSize / _flutterView!.devicePixelRatio;
    }

    return null;
  }

  @override
  void dispose() {
    _widgetsBinding.removeObserver(this);
    _appVersionController.close();
  }
}

extension _SizeExtension on Size {
  AppVersionEnum get appVersionEnum {
    if (width > KPlatformConstants.minWidthThresholdDesk) {
      return AppVersionEnum.desk;
    } else if (width > KPlatformConstants.minWidthThresholdTablet) {
      return AppVersionEnum.tablet;
    } else {
      return AppVersionEnum.mobile;
    }
  }
}
