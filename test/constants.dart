import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_development.dart';
import 'package:veteranam/shared/shared.dart';

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
  static const network = 'Reload network';
  static const offlineNetwork = 'offline network banner';
  static const goRouter = 'Mock Go Router';
  static const goTo = 'go to';
  static const validationError = 'Validation error';
  static const full = 'full';
  static const nullable = 'nullable';
  static const convertor = 'convertor';
  static const shouldNotBe = 'Should not be';
  static const shouldBe = 'Should be';
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
  static const stream = 'Stream';
  static const smallList = 'Small list';
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

  static const phoneNumber = '+3809900000';

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
    photo: image,
  );

  static const image = 'test';

  static const userWithoutPhoto = User(
    id: '1',
    email: userEmail,
    name: usernameCorrect,
    phoneNumber: 'test_phone_number',
  );

  static final userPhotoModel = ImageModel(
    downloadURL: user.photo!,
  );

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
    downloadURL: image,
    lastModifiedTS: 1,
    name: 'test_name',
    ref: image,
    type: 'test_type',
  );
  static const imageModels = ImageModel(
    downloadURL: image,
    name: image,
    ref: image,
  );
  static const resume = ResumeModel(
    downloadURL: downloadURL,
    lastModifiedTS: 1,
    name: 'test_name',
    ref: 'test_name',
    type: 'test_type',
  );
  static const resumeModel = ResumeModel(
    downloadURL: downloadURL,
    name: downloadURL,
    ref: downloadURL,
  );

  static final feedbackModel = FeedbackModel(
    id: '',
    guestId: user.id,
    guestName: field,
    email: userEmail,
    timestamp: dateTime,
    message: field,
  );
  static final feedbackImageModel = FeedbackModel(
    id: '',
    guestId: user.id,
    guestName: null,
    email: null,
    timestamp: dateTime,
    message: field,
    image: imageModel,
  );
  static final dateTime = DateTime(2024, 4, 12);
  static final dateTimeId = DateTime(0, 0, 0, 0, 1, 1, 1, 1);
  static const downloadURL = 'test_URL.test';
  static const id = '1';

  static final discountModelItems = <DiscountModel>[
    for (var i = 0; i < 50; i++)
      KMockText.discountModel.copyWith(
        id: i.toString(),
        userId: i.toString(),
        dateVerified: dateTime,
        subLocation: i == 0
            ? SubLocation.all
            : i == 1
                ? SubLocation.allStoresOfChain
                : i == 2
                    ? SubLocation.online
                    : null,
        userPhoto: i > _itemsPhoto ? imageModels : null,
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

  static final repositoryDiscountModelItems = <DiscountModel>[
    for (var i = 0; i < 5; i++)
      KMockText.discountModel.copyWith(
        id: i.toString(),
        userId: i.toString(),
        dateVerified: dateTime,
      ),
  ];

  static final discountModelItemsModify = <DiscountModel>[
    for (var i = 0; i < 50; i++)
      KMockText.discountModel.copyWith(
        company: i == 0 ? null : KMockText.discountModel.company,
        expiration: i == 0 ? null : KMockText.discountModel.expiration,
        id: i.toString(),
        userId: i.toString(),
        categoryEN: i == 0 ? KMockText.tag : KMockText.discountModel.categoryEN,
        category: i == 0 ? KMockText.tag : KMockText.discountModel.category,
        dateVerified: dateTime,
        discount: i == 0 ? [12, 35, 100] : KMockText.discountModel.discount,
        subLocation: i == 0
            ? SubLocation.all
            : i == 1
                ? SubLocation.allStoresOfChain
                : i == 2
                    ? SubLocation.online
                    : null,
      ),
  ];

  static final fundItems = <FundModel>[
    for (var i = 0; i < _items; i++)
      KMockText.fundModel.copyWith(
        id: i.toString(),
      ),
  ];

  static final fundItemsWithImage = <FundModel>[
    for (var i = 0; i < 40; i++)
      KMockText.fundModel.copyWith(
        id: i.toString(),
        image: imageModel,
      ),
  ];

  static final feedbackModelIncorect = FeedbackModel(
    id: dateTime.microsecondsSinceEpoch.toString(),
    guestId: dateTime.microsecondsSinceEpoch.toString(),
    guestName: field,
    email: userEmailIncorrect,
    timestamp: dateTime,
    message: field,
  );

  static final informationModelItemsModify = <InformationModel>[
    for (var i = 0; i < _items; i++)
      KMockText.informationModel.copyWith(
        id: i.toString(),
        fetchDate: dateTime,
        image: i > _itemsPhoto ? imageModels : null,
        categoryUA:
            i == 0 ? KMockText.tag : KMockText.informationModel.categoryUA,
        category: i == 0 ? KMockText.tag : KMockText.informationModel.category,
      ),
  ];

  static final informationModelItems = <InformationModel>[
    for (var i = 0; i < _items; i++)
      KMockText.informationModel.copyWith(
        id: i.toString(),
        fetchDate: dateTime,
        image: i > _itemsPhoto ? imageModels : null,
      ),
  ];

  static final storyModelItems = <StoryModel>[
    for (var i = 0; i < _items; i++)
      StoryModel(
        id: i.toString(),
        date: dateTime,
        image: i > _itemsPhoto ? imageModels : null,
        story: KMockText.cardData.substring(0, 200),
        userName: user.name,
        userId: user.id,
        userPhoto: i > _itemsPhoto ? userPhotoModel : null,
      ),
  ];
  static const _items = 40;
  static const _itemsPhoto = 30;

  static List<String> routes({required bool hasAccount}) => [
        KRoute.aboutUs.name,
        KRoute.support.name,
        KRoute.stories.name,
        KRoute.discounts.name,
        if (hasAccount) KRoute.profile.name else KRoute.login.name,
        KRoute.work.name,
        KRoute.information.name,
        KRoute.consultation.name,
      ];

  static final reportModel = ReportModel(
    id: id,
    reasonComplaint: ReasonComplaint.fraudOrSpam,
    // email: userEmail,
    message: field,
    date: dateTime,
    card: CardEnum.funds,
    userId: user.id,
    cardId: id,
  );

  static final reportItems = <ReportModel>[
    for (var i = 0; i < 3; i++)
      ReportModel(
        id: i.toString(),
        reasonComplaint: ReasonComplaint.fraudOrSpam,
        // email: userEmail,
        message: field,
        date: dateTime,
        card: CardEnum.discount,
        userId: user.id,
        cardId: id,
      ),
  ];

  static final reportModelIncorect = ReportModel(
    id: id,
    reasonComplaint: ReasonComplaint.fraudOrSpam,
    // email: userEmailIncorrect,
    message: field,
    date: dateTime,
    card: CardEnum.funds,
    userId: user.id,
    cardId: id,
  );
  static const employeeRespondModel = EmployeeRespondModel(
    id: id,
    email: userEmail,
    phoneNumber: phoneNumber,
    resume: resumeModel,
    noResume: false,
  );
  static const employeeRespondWithoudResumeModel = EmployeeRespondModel(
    id: id,
    email: userEmail,
    phoneNumber: phoneNumber,
    noResume: true,
  );
  static final linkModel = LinkModel(
    id: id,
    userId: user.id,
    link: 'https://veteranam.info/',
    date: dateTime,
  );
  static final linkModelWrong = LinkModel(
    id: id,
    userId: user.id,
    link: 'https://veteranam.info/$field',
    date: dateTime,
  );
  static final emailModel = EmailModel(
    id: id,
    userId: user.id,
    email: 'test.email@gmail.com',
    date: dateTime,
    isValid: true,
  );
  static final emailModelWrong = EmailModel(
    id: id,
    userId: user.id,
    email: field,
    date: dateTime,
  );
}

abstract class KTestConstants {
  static const scrollingDown = Offset(0, -10000);
  static const scrollingDown100 = Offset(0, -100);
  static const scrollingUp = Offset(0, 10000);
  static const scrollingUp200 = Offset(0, 200);
  static const scrollingUp150 = Offset(0, 150);
  static const scrollingUp500 = Offset(0, 500);
  static const scrollingUp1000 = Offset(0, 1000);
  static const scrollingUp1500 = Offset(0, 1500);

  static const windowDeskSize = Size(1700, 1700);
  static const windowMobileSize = Size(700, 700);
  static const windowSmallSize = Size(500, 500);

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
  static const myStory = 'My Story Screen';
  static const feedback = 'Feedback Screen';
  static const mobSettings = 'Settings Screen';
  static const mobFaq = 'Mob FAQ Screen';

  static const authenticationServices = 'Authentication Services';
  static const appRepository = 'App';
  static const authentication = ' Authentication';
  static const network = ' Network';
  static const firestoreService = 'Firestore Service';
  static const secureStorage = 'Secure Storage';
  static const filter = 'Filter';
  static const scroll = 'scroll';
  static const image = 'image';
  static const casheClient = 'cashe client';
  static const url = 'URL';

  static const report = 'Report Dialog';
  static const privacyPolicy = 'Privacy Policy Dialog';
  static const discountCard = 'Discount Card Dialog';
  static const newsCard = 'News Card Dialog';

  static const prod = 'PROD';
  static const dev = 'DEV';
  static const mobile = 'MOBILE $prod';
}
