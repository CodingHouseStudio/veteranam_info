// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kozak/bootstrap.dart';
import 'package:kozak/shared/shared.dart';

Future<void> setUpGlobal({bool? kIsWeb}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
}

abstract class KGroupText {
  static const repository = 'Repository';
  static const successfulGet = 'Successful get';
  static const intial = 'renders initial';
  static const goRouter = 'Mock Go Router';
  static const goTo = 'go to';
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

  static const field = 'field_test';

  static const questionModelItems = <QuestionModel>[
    QuestionModel(
      id: '1',
      title: 'Як мені знайти роботу за допомогою цього сайту?',
      subtitle:
          'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи, '
          'таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні '
          'ресурси. Виберіть свою область інтересів та регіон, і шукайте '
          'вакансії, які відповідають вашим критеріям.',
    ),
  ];
}

abstract class KTestConstants {
  static const scrollingDown100 = Offset(0, -100);
  static const scrollingUp400 = Offset(0, 100);
  static const scrollingDown = Offset(0, -4000);
  static const scrollingUp = Offset(0, 4000);

  static const windowTabletSize = Size(1500, 1500);

  static const englishIndex = 1;
  static const ukrainIndex = 0;
}

abstract class KScreenBlocName {
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

  static const filterCubit = 'Filter Cubit';
  static const languageCubit = 'Language Cubit';
  static const homeBloc = 'Home Bloc';
}
