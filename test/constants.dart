import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kozak/bootstrap.dart';

Future<void> setUpGlobal({bool? kIsWeb}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
}

abstract class KTestData {
  static const windowTableetSize = Size(1200, 1200);
}

abstract class KTestText {
  static const filter = 'filter_test';

  static const String usernameCorrect = 'test_username';
  static const String passwordCorrect = 'test_password';
  static const String usernameEmpty = '';
  static const String passwordEmpty = '';
  static const String usernameIncorrect = 'test_';
  static const String passwordIncorrect = 'test_';

  static const filterCubit = 'Filter Cubit';
}

abstract class KTestConstants {
  static const scrollingDown = Offset(0, -500);
  static const scrollingUp = Offset(0, 500);
}
