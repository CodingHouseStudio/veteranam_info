import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kozak/bootstrap.dart';
import 'package:kozak/firebase_options_development.dart';
import 'package:kozak/shared/shared.dart';

Future<void> setUpGlobal({bool? kIsWeb}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  if (kIsWeb != null) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(); // normally would initialize Firebase
  }

  // FlutterSecureStorage.setMockInitialValues({});
}

abstract class KGroupText {
  static const repository = 'Repository';
  static const model = 'Model';
  static const fiedlModel = 'Field model';
  static const successfulGet = 'Successful get';
  static const successfulSet = 'Successful set';
  static const failureGet = 'Failure get';
  static const failureSet = 'Failure set';
  static const intial = 'renders initial';
  static const goRouter = 'Mock Go Router';
  static const goTo = 'go to';
  static const validationError = 'Validation error';
  static const shouldBe = 'should be';
  static const shouldNotBe = 'should not be';
  static const empty = 'empty';
  static const modelJson = 'instance from valid JSON';
}

abstract class KTestText {
  static const filter = 'filter_test';

  static const usernameCorrect = 'test_username';
  static const passwordCorrect = 'test_password';
  static const usernameEmpty = '';
  static const passwordEmpty = '';
  static const usernameIncorrect = 'test_';
  static const passwordIncorrect = 'test_';

  static const useremail = 'example@gmail.com';
  static const useremailIncorrect = 'examplegmail.com';
  static const shortUserEmail = '@.com';

  static const footer = 'Контакти\n';

  static const field = 'field_test';
  static const fieldEmpty = '';

  static final boxRoutes = [
    '${KRoute.home.path}${KRoute.discounts.path}',
    '${KRoute.home.path}${KRoute.work.path}',
    '${KRoute.home.path}${KRoute.information.path}',
    '${KRoute.home.path}${KRoute.story.path}',
    '${KRoute.home.path}${KRoute.investors.path}',
  ];

  static const questionModelItems = <QuestionModel>[
    QuestionModel(
      id: '1',
      title: 'Як мені знайти роботу за допомогою цього сайту?',
      subtitle:
          'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи,'
          ' таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні '
          'ресурси. Виберіть свою область інтересів та регіон, і шукайте '
          'вакансії, які відповідають вашим критеріям.',
    ),
  ];

  static final feedbackModel = FeedbackModel(
    id: DateTime(2024, 4, 12, 0, 0, 0, 1).microsecondsSinceEpoch.toString(),
    guestId:
        DateTime(2024, 4, 12, 0, 0, 0, 1).microsecondsSinceEpoch.toString(),
    guestName: KTestText.field,
    email: KTestText.useremail,
    timestamp: DateTime(2024, 4, 12, 0, 0, 0, 1),
    message: KTestText.field,
  );

  static final feedbackModelIncorect = FeedbackModel(
    id: DateTime(2024, 4, 12, 0, 0, 0, 1).microsecondsSinceEpoch.toString(),
    guestId:
        DateTime(2024, 4, 12, 0, 0, 0, 1).microsecondsSinceEpoch.toString(),
    guestName: KTestText.field,
    email: KTestText.useremailIncorrect,
    timestamp: DateTime(2024, 4, 12, 0, 0, 0, 1),
    message: KTestText.field,
  );

  static final informationModelItems = <InformationModel>[
    InformationModel(
      id: '1',
      title: 'Як мені знайти роботу за допомогою цього сайту?',
      news: 'Використовуйте веб-сайти спеціалізованих сервісів для'
          ' пошуку роботи,'
          ' таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні '
          'ресурси. Виберіть свою область інтересів та регіон, і шукайте '
          'вакансії, які відповідають вашим критеріям.',
      date: DateTime.now(),
      tags: ['test_tags_1'],
    ),
    InformationModel(
      id: '2',
      title: 'Як мені знайти роботу за допомогою цього сайту?',
      news:
          'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи,'
          ' таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні '
          'ресурси. Виберіть свою область інтересів та регіон, і шукайте '
          'вакансії, які відповідають вашим критеріям.',
      date: DateTime.now(),
      tags: ['test_tags_2'],
    ),
  ];
}

abstract class KTestConstants {
  static const scrollingDown = Offset(0, -10000);
  static const scrollingDown500 = Offset(0, -500);
  static const scrollingUp = Offset(0, 10000);
  static const scrollingAppBar = Offset(0, KSize.kPreferredSize);

  static const windowTabletSize = Size(1700, 1700);

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
  static const feedback = 'Feedback Widget';

  static const filterCubit = 'Filter Cubit';
  static const languageCubit = 'Language Cubit';
  static const homeBloc = 'Home Bloc';
  static const feedbackBloc = 'Feedback Bloc';
  static const informationBloc = 'Information Bloc';
}
