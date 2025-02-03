import 'dart:async' show FutureOr;
import 'dart:developer' show log;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors, Widget, runApp;
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:intl/date_symbol_data_local.dart';
import 'package:veteranam/shared/helper/helper.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log(
      'onChange(${bloc.runtimeType}, $change)',
      sequenceNumber: KDimensions.sequenceNumberData,
      level: KDimensions.logLevelData,
      name: 'Bootstrap DATA',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log(
      'Bloc Error Runtime Type - ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
      sequenceNumber: KDimensions.logLevelWarning,
      level: KDimensions.logLevelWarning,
      name: 'Bootstrap Bloc Error',
    );
    super.onError(bloc, error, stackTrace);
  }
}

/// COMMENT: Method adds dependencies in App
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  Bloc.observer = const AppBlocObserver();

// Set only Vertical orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (!Config.kIsWeb) {
    if (PlatformEnum.getPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  await configureDependencies();

  await initializeDateFormatting();

  // Add cross-flavor configuration here
  if (Config.kIsWeb) {
    usePathUrlStrategy();
  }

  // Add cross-flavor configuration here

  runApp(await builder());
}
