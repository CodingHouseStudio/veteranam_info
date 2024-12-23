import 'dart:io' show Platform;

import 'package:veteranam/shared/constants/config.dart';

enum LoadingStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isLoading =>
      this == LoadingStatus.initial || this == LoadingStatus.loading;
}

//enum EvaluationEnum { like, dislike, smile, none }

enum UrlEnum {
  shareError,
  linkError,
  copyError,
  error,
  copySucceed,
  copyLinkSucceed,
}

enum CategoryEnum { all }

enum AuthenticationStatus {
  unknown,
  anonymous,
  authenticated,
} //unauthenticated

enum MobMode {
  online,
  offline;

  bool get isOffline => this == MobMode.offline;
  MobMode get switchMode => isOffline ? MobMode.online : MobMode.offline;
}

enum NetworkStatus {
  network,
  offline;

  bool get isOffline => this == NetworkStatus.offline;
}

enum PlatformEnum {
  android,
  ios,
  web,
  unknown;

  bool get isAndroid => this == PlatformEnum.android;
  bool get isIOS => this == PlatformEnum.ios;
  bool get isWeb => this == PlatformEnum.web;
  bool get isUnkown => this == PlatformEnum.unknown;

  static PlatformEnum get getPlatform {
    try {
      if (Config.isWeb) {
        return PlatformEnum.web;
      } else if (Platform.isAndroid) {
        return PlatformEnum.android;
      } else if (Platform.isIOS) {
        return PlatformEnum.ios;
      }
      return PlatformEnum.unknown;
    } catch (e) {
      return PlatformEnum.unknown;
    }
  }
}

enum DiscountEnum {
  featured,
  byDate,
  largestSmallest,
}

enum ErrorLevelEnum {
  fatal,
  error,
  info,
  warning;
}
