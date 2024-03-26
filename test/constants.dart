import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kozak/bootstrap.dart';

const String usernameCorrect = 'test_username';
const String passwordCorrect = 'test_password';
const String usernameEmpty = '';
const String passwordEmpty = '';
const String usernameIncorrect = 'test_';
const String passwordIncorrect = 'test_';

Future<void> setUpGlobal({bool? kIsWeb}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
}
