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

abstract class KTestText {
  static const filter = 'filter_test';

  static const String usernameCorrect = 'test_username';
  static const String passwordCorrect = 'test_password';
  static const String usernameEmpty = '';
  static const String passwordEmpty = '';
  static const String usernameIncorrect = 'test_';
  static const String passwordIncorrect = 'test_';

  static const String useremail = 'example@gmail.com';

  static const String footer = 'Контакти\n';

  static const filterCubit = 'Filter Cubit';

  static const field = 'field_test';
}

abstract class KTestConstants {
  static const scrollingDown100 = Offset(0, -100);
  static const scrollingDown = Offset(0, -4000);
  static const scrollingUp = Offset(0, 4000);

  static const windowTabletSize = Size(1500, 1500);
}

abstract class KScreenName {
  static const app = 'App Screen';
  static const error = 'Error Screen';
  static const home = 'Home Screen';
  static const discounts = 'Discounts Screen';
  static const information = 'Information Screen';
  static const investors = 'Investors Screen';
  static const profile = 'Profile Screen';
  static const story = 'Story Screen';
  static const work = 'Work Screen';
  static const aboutUs = 'About Us Screen';
  static const contact = 'Contact Screen';
  static const consultation = 'Consultation Screen';
}
