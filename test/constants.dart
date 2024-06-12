import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
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
  static const bloc = 'Bloc';
  static const cubit = 'Cubit';
  static const repository = 'Repository';
  static const provider = 'Provider';
  static const model = 'Model';
  static const fiedlModel = 'Field model';
  static const successfulGet = 'Successful get';
  static const successful = 'Successful';
  static const successfulSet = 'Successful set';
  static const failureGet = 'Failure get';
  static const failure = 'Failure';
  static const firebaseFailure = 'Firebase Failure';
  static const failureSend = 'Failure set';
  static const intial = 'renders initial';
  static const goRouter = 'Mock Go Router';
  static const goTo = 'go to';
  static const validationError = 'Validation error';
  static const shouldBe = 'should be';
  static const shouldNotBe = 'should not be';
  static const empty = 'empty';
  static const modelJson = 'instance from valid JSON';
  static const jsonModel = 'json from valid model';
  static const correct = 'Correct';
  static const uncorrect = 'Uncorrect';
  static const getList = 'Get list';
  static const getEmptyList = 'Get empty list';
  static const mockButton = 'Tap on the mock button';
  static const error = 'Error';
  static const failureNetwork = 'Failure Network';
  static const successfulDelete = 'Successful delete';
  static const failureDelete = 'Failure delete';
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
  static const token = 'test_token';

  static const userEmail = 'example@gmail.com';
  static const useremailWrong = 'examplewrong@gmail.com';
  static const userEmailIncorrect = 'examplegmail.com';
  static const shortUserEmail = '@.com';

  static const footer = 'Контакти\n';

  static const field = 'field_test';
  static const fieldEmpty = '';

  static final questionModelItems = <QuestionModel>[
    QuestionModel(
      id: '0',
      title: KMockText.questionTitle.first,
      subtitle: KMockText.questionSubtitle,
      navigationLink: 'test_link',
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

  static const authCredential = firebase_auth.AuthCredential(
    providerId: '1',
    signInMethod: 'test_method',
    accessToken: 'test_access_token',
    token: 1,
  );

  static const oAuthCredential = firebase_auth.OAuthCredential(
    providerId: '1',
    signInMethod: 'test_method',
    accessToken: 'test_access_token',
    idToken: '1',
    rawNonce: 'row_test',
    secret: 'secret_test',
    serverAuthCode: 'server_code_test',
  );

  static const user = User(
    id: '1',
    email: userEmail,
    name: usernameCorrect,
    phoneNumber: 'test_phone_number',
    photo: 'test_phot',
  );

  static const userWithoutPhoto = User(
    id: '1',
    email: userEmail,
    name: usernameCorrect,
    phoneNumber: 'test_phone_number',
  );

  static final userPhotoModel = [
    ImageModel(
      downloadURL: user.photo!,
    ),
  ];

  static const userSetting = UserSetting(
    id: '1',
    userRole: UserRole.civilian,
  );

  static const userSettingModel = UserSetting(
    id: '1',
    userRole: UserRole.civilian,
    locale: Language.english,
    roleIsConfirmed: true,
  );
  static const imageModel = ImageModel(
    downloadURL: 'test_URL',
    lastModifiedTS: 1,
    name: 'test_name',
    ref: 'test_name',
    type: 'test_type',
  );
  static const imageModels = [
    ImageModel(
      downloadURL: 'test_image',
      name: 'test_image',
      ref: 'test_image',
    ),
  ];

  static final feedbackModel = FeedbackModel(
    id: dateTime.microsecondsSinceEpoch.toString(),
    guestId: KTestText.user.id,
    guestName: KTestText.field,
    email: KTestText.userEmail,
    timestamp: dateTime,
    message: KTestText.field,
  );
  static final dateTime = DateTime(2024, 4, 12);
  static final dateTimeId = DateTime(0, 0, 0, 0, 1, 1, 1, 1);
  static const downloadURL = 'test_URL';

  static final discountModelItems = <DiscountModel>[
    for (var i = 0; i < 50; i++)
      KMockText.discountModel.copyWith(
        id: i.toString(),
        userId: i.toString(),
        dateVerified: dateTime,
      ),
  ];

  static final userDiscountModelItems = <DiscountModel>[
    for (var i = 0; i < 5; i++)
      KMockText.discountModel.copyWith(
        id: i.toString(),
        userId: userWithoutPhoto.id,
        dateVerified: dateTime,
      ),
  ];

  static final discountModelItemsModify = <DiscountModel>[
    for (var i = 0; i < 50; i++)
      KMockText.discountModel.copyWith(
        id: i.toString(),
        userId: i.toString(),
        category: i == 0 ? KMockText.tag : KMockText.discountModel.category,
        dateVerified: dateTime,
      ),
  ];

  static final fundItems = <FundModel>[
    for (var i = 0; i < 5; i++)
      KMockText.fundModel.copyWith(
        id: i.toString(),
      ),
  ];

  static final feedbackModelIncorect = FeedbackModel(
    id: dateTime.microsecondsSinceEpoch.toString(),
    guestId: dateTime.microsecondsSinceEpoch.toString(),
    guestName: KTestText.field,
    email: KTestText.userEmailIncorrect,
    timestamp: dateTime,
    message: KTestText.field,
  );

  static final informationModelItemsModify = <InformationModel>[
    for (var i = 0; i < KMockText.tags.length; i++)
      KMockText.informationModel.copyWith(
        id: i.toString(),
        fetchDate: dateTime,
        image: i > KMockText.tags.length - 2 ? imageModels : null,
        category: i == 0 ? KMockText.tag : KMockText.informationModel.category,
      ),
  ];

  static final informationModelItems = <InformationModel>[
    for (var i = 0; i < KMockText.tags.length; i++)
      KMockText.informationModel.copyWith(
        id: i.toString(),
        fetchDate: dateTime,
        image: i > KMockText.tags.length - 2 ? imageModels : null,
      ),
  ];

  static final storyModelItems = <StoryModel>[
    for (var i = 0; i < KMockText.tags.length; i++)
      StoryModel(
        id: i.toString(),
        date: dateTime,
        image: i > KMockText.tags.length - 2 ? imageModels : null,
        story: KMockText.cardData.substring(0, 200),
        userName: user.name,
        userId: user.id,
        userPhoto: i > KMockText.tags.length - 2 ? userPhotoModel : null,
      ),
  ];

  static List<String> routes({required bool hasAccount}) => [
        KRoute.aboutUs.name,
        KRoute.investors.name,
        KRoute.stories.name,
        KRoute.discounts.name,
        if (hasAccount) KRoute.profile.name else KRoute.login.name,
        KRoute.work.name,
        KRoute.information.name,
        KRoute.consultation.name,
      ];
}

abstract class KTestConstants {
  static const scrollingDown = Offset(0, -10000);
  static const scrollingUp = Offset(0, 10000);
  static const scrollingUp200 = Offset(0, 200);
  static const scrollingUp500 = Offset(0, 500);
  static const scrollingUp1000 = Offset(0, 1000);
  static const scrollingUp1500 = Offset(0, 1500);

  static const windowTabletSize = Size(1700, 1700);
  static const windowMobileSize = Size(700, 700);

  static const englishIndex = 1;
  static const ukrainIndex = 0;
}

abstract class KScreenBlocName {
  static const app = 'App Screen';
  static const error = 'Error Screen';
  static const home = 'Home Screen';
  static const discount = 'Discounts Screen';
  static const information = 'Information Screen';
  static const investors = 'Investors Screen';
  static const profile = 'Profile Screen';
  static const story = 'Story Screen';
  static const work = 'Work Screen';
  //  static const contact = 'Contact Screen';
  static const aboutUs = 'About Us Screen';
  static const consultation = 'Consultation Screen';
  static const login = 'Login Screen';
  static const signUp = 'Sign Up Screen';
  static const questionsForm = 'Questions Form Screen';
  static const workEmployee = 'Work Employee Screen';
  static const employeeRespond = 'Employee Respond Screen';
  static const workEmployer = 'Employer Screen';
  static const profileSaves = 'Profile Saves Screen';
  static const storyAdd = 'Story Add Screen';
  static const thank = 'Thank Screen';
  static const profileMyStory = 'My Story Screen';
  static const underConstruction = 'Under Construction Screen';
  static const myDiscounts = 'My Discount Screen';

  static const feedback = 'Feedback Widget';
  static const authenticationServices = 'Authentication Services';
  static const appAuthentication = 'App Authentication';
  static const authentication = ' Authentication';
  static const firestoreService = 'Firestore Service';
  static const secureStorage = 'Secure Storage';
  static const filter = 'Filter';
  static const scroll = 'scroll';
  static const image = 'image';
}
