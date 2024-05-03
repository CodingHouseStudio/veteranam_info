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
  static const key = 'key_test';

  static const usernameCorrect = 'test_username';
  static const passwordCorrect = 'test_Password1';
  static const passwordWrong = 'test_Password1_wrong';
  static const usernameEmpty = '';
  static const passwordEmpty = '';
  static const usernameIncorrect = 'test_';
  static const passwordIncorrect = 'test_password';
  static const passwordIncorrectNumber = 'test_Password';
  static const shortPassword = 'Pas1';

  static const useremail = 'example@gmail.com';
  static const useremailWrong = 'examplewrong@gmail.com';
  static const useremailIncorrect = 'examplegmail.com';
  static const shortUserEmail = '@.com';

  static const footer = 'Контакти\n';

  static const field = 'field_test';
  static const fieldEmpty = '';

  static final questionModelItems = <QuestionModel>[
    QuestionModel(
      id: '0',
      title: KMockText.questionTitle.first,
      subtitle: KMockText.questionSubtitle,
    ),
  ];

  static final workModelItems = <WorkModel>[
    for (var i = 0; i < 50; i++)
      const WorkModel(
        id: '1',
        title: KMockText.workTitle,
        description: KMockText.workDescription,
        employerContact: KMockText.email,
        price: KMockText.workPrice,
        city: KMockText.workCity,
        companyName: KMockText.workEmployer,
        category: KMockText.workCategory,
      ),
  ];

  static const user = User(
    id: '1',
    email: useremail,
    name: usernameCorrect,
    phoneNumber: 'test_phone_number',
    photo: 'test_phot',
  );

  static final feedbackModel = FeedbackModel(
    id: dateTime.microsecondsSinceEpoch.toString(),
    guestId: dateTime.microsecondsSinceEpoch.toString(),
    guestName: KTestText.field,
    email: KTestText.useremail,
    timestamp: dateTime,
    message: KTestText.field,
  );
  static final dateTime = DateTime(2024, 4, 12);
  static final dateTimeId = DateTime(0, 0, 0, 0, 1, 1, 1, 1);

  static const fundItems = <FundModel>[
    FundModel(
      id: '1',
      title: 'Test_title',
      subtitle: 'Test_subtitle',
      link: 'Test_limk',
    ),
  ];

  static final feedbackModelIncorect = FeedbackModel(
    id: dateTime.microsecondsSinceEpoch.toString(),
    guestId: dateTime.microsecondsSinceEpoch.toString(),
    guestName: KTestText.field,
    email: KTestText.useremailIncorrect,
    timestamp: dateTime,
    message: KTestText.field,
  );

  static final informationModelItems = <InformationModel>[
    for (var i = 0; i < KMockText.tags.length; i++)
      InformationModel(
        id: i.toString(),
        title: KMockText.title,
        news: KMockText.cardData,
        date: dateTime,
        image: i > KMockText.tags.length - 2 ? KMockText.image : null,
        tags: KMockText.tags.elementAt(i),
      ),
  ];
}

abstract class KTestConstants {
  static const scrollingDown = Offset(0, -10000);
  static const scrollingDown500 = Offset(0, -500);
  static const scrollingDown1000 = Offset(0, -1000);
  static const scrollingUp = Offset(0, 10000);
  static const scrollingUp200 = Offset(0, 200);
  static const scrollingUp500 = Offset(0, 500);
  static const scrollingUp1000 = Offset(0, 1000);

  static const windowTabletSize = Size(1700, 1700);
  static const windowMobileSize = Size(700, 700);

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
  static const login = 'Login Screen';
  static const signUp = 'Sign Up Screen';
  static const questionsForm = 'Questions Form Screen';
  static const workEmployee = 'Work Employee Screen';
  static const workRespond = 'Work Respond Screen';
  static const employer = 'Employer Screen';

  static const feedback = 'Feedback Widget';

  static const filterCubit = 'Filter Cubit';
  static const languageCubit = 'Language Cubit';
  static const homeBloc = 'Home Bloc';
  static const feedbackBloc = 'Feedback Bloc';
  static const authenticationServicesCubit = 'Authentication Services Cubit';
  static const authenticationBloc = 'Authentication Bloc';
  static const loginBloc = 'Login Bloc';
  static const signUpBloc = 'Sign Up Bloc';
  static const scrollCubit = 'Scroll Cubit';
  static const informationBloc = 'Information Bloc';
  static const investorsBloc = 'Investors Bloc';
  static const workEmployeeBloc = 'Work Bloc';

  static const iAppAuthenticationRepository = 'App Authentication';
  static const authentication = 'Authentication';
  static const secureStorage = 'Secure Storage';
}
