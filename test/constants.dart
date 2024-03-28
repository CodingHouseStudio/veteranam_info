import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozak/bootstrap.dart';

Future<void> setUpGlobal({bool? kIsWeb}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
}

abstract class KBlocName {
  static const filter = 'Filter Cubit';
}

abstract class KTestText {
  static const filter = 'filter_test';

  static const String usernameCorrect = 'test_username';
  static const String passwordCorrect = 'test_password';
  static const String usernameEmpty = '';
  static const String passwordEmpty = '';
  static const String usernameIncorrect = 'test_';
  static const String passwordIncorrect = 'test_';
}
