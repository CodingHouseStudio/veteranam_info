import 'dart:async' show FutureOr;
import 'dart:developer' show log;
import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors, Widget, runApp, runWidget;
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:intl/date_symbol_data_local.dart';
import 'package:veteranam/multi_view_app.dart';
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
  if (!Config.kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            Platform.isIOS ? Colors.transparent : AppColors.materialThemeWhite,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.materialThemeKeyColorsNeutral,
        systemNavigationBarDividerColor:
            AppColors.materialThemeKeyColorsNeutral,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  configureDependencies();

  await initializeDateFormatting();

  // Add cross-flavor configuration here
  if (Config.kIsWeb) {
    usePathUrlStrategy();
  }

  // Add cross-flavor configuration here
  if (!Config.isWeb) {
    runApp(await builder());
  } else {
    final widget = await builder();
    runWidget(MultiViewApp(viewBuilder: (context) => widget));
  }
}
