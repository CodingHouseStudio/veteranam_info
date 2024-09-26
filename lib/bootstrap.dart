import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:veteranam/shared/shared.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// COMMENT: Method adds dependencies in App
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  Bloc.observer = const AppBlocObserver();
  if (!kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.materialThemeWhite,
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

  // await initializeDateFormatting();

  // Add cross-flavor configuration here
  if (kIsWeb) {
    usePathUrlStrategy();
  }

  // Add cross-flavor configuration here

  runApp(await builder());
}
