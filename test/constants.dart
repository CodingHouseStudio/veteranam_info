import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_development.dart' as dev;
import 'package:veteranam/firebase_options_development.dart' as prod;
import 'package:veteranam/shared/constants/constants_dart.dart';
import 'package:veteranam/shared/models/models.dart';

Future<void> setUpGlobal({bool? kIsWeb}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: Config.isDevelopment
          ? dev.DefaultFirebaseOptions.currentPlatform
          : prod.DefaultFirebaseOptions.currentPlatform,
      name: Config.isWeb ? 'TESTWEB' : 'TESTMOBILE',
    );
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
  static const initial = 'renders initial';
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
  static const authenticated = 'Authentication Status is Authenticated';
}

abstract class KTestText {
  static const filter = 'filter_test';
  static const key = 'key_test';
  static const nickname = 'nickname';

  static const usernameCorrect = 'testUsername';
  static const nameCorrect = 'testName';
  static const nameIncorrect = 'testName**';
  static const surnameCorrect = 'testSurname';
  static const nicknameCorrect = 'testNickname';
  static const nicknameIncorrect = 'test@Nickname!';
  static const passwordCorrect = 'test_Password1';
  static const passwordWrong = 'test_Password1_wrong';
  static const usernameEmpty = '';
  static const passwordEmpty = '';
  static const usernameIncorrect = 'test_';
  static const passwordIncorrect = 'test_password';
  static const passwordIncorrectNumber = 'test_Password';
  static const shortPassword = 'Pas1';
  static const token = 'test_token';
  static const code = 'test_code';

  static const userEmail = 'example@gmail.com';
  static const useremailWrong = 'examplewrong@gmail.com';
  static const userEmailIncorrect = 'examplegmail.com';
  static const shortUserEmail = '@.com';

  static const footer = 'Контакти\n';

  static const field = 'field_test';
  static const fieldEmpty = '';

  static const phoneNumber = '+3809900000';
  static const build = '50';

  static const version = '0.5.0';
  static const oldVersion = '0.2.0';

  static const developerEmail = 'developer@codinghouse.biz';

  static final questionModelItems = <QuestionModel>[
    KMockText.questionModel,
  ];

  static final workModelItems = <WorkModel>[
    for (var i = 0; i < _items; i++)
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

  static const pureCompanyModel = CompanyModel(
    id: id,
    userEmails: userEmailList,
  );

  static const fullCompanyModel = CompanyModel(
    id: id,
    userEmails: userEmailList,
    code: companyCode,
    companyName: companyName,
    publicName: companyName,
    link: link,
  );
  static const idCompanyModel = CompanyModel(
    id: id,
    userEmails: [],
  );
  static const companyName = 'test';
  static const companyCode = '12345678';
  static const companyWrongCode = '123456';
  static const companyWrongName = 't';
  static const userEmailList = [userEmail];

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

  static const pureUser = User(
    id: id,
  );

  static const userAnonymous = User(
    id: '1',
  );

  static const profileUser = User(
    id: '1',
    email: userEmail,
    name: '$nameCorrect $surnameCorrect',
    phoneNumber: 'test_phone_number',
    photo: image,
  );

  static const profileUserWithoutPhoto = User(
    id: '1',
    email: userEmail,
    name: '$nameCorrect $surnameCorrect',
    phoneNumber: 'test_phone_number',
  );

  static const profileIncorrectUser = User(
    id: '1',
    email: userEmail,
    name: '$nameIncorrect $surnameCorrect',
    phoneNumber: 'test_phone_number',
    photo: image,
  );

  static const image = 'test';

  static const imagePath = '.png';

  static final filePickerPathItem = FilePickerItem(
    bytes: Uint8List(1),
    name: '$image$imagePath',
    ref: image,
    extension: imagePath,
  );

  static final filePickerItem =
      FilePickerItem(bytes: Uint8List(1), name: image, ref: image);

  static final filePickerItemEmpty =
      FilePickerItem(bytes: Uint8List(0), name: image, ref: image);

  static final filePickerItemFeedback =
      FilePickerItem(bytes: Uint8List(1), name: null, ref: null);

  static final filePickerItemFeedbackWrong =
      FilePickerItem(bytes: Uint8List(2), name: null, ref: null);

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

  static const repositoryUserSetting = UserSetting(
    id: field,
    nickname: nicknameCorrect,
  );

  static final userSettingModel = UserSetting(
    id: '1',
    userRole: UserRole.civilian,
    locale: Language.english,
    roleIsConfirmed: true,
    devicesInfo: [deviceInfoModel],
    nickname: nicknameCorrect,
  );

  static final userSettingModelIncorrect = UserSetting(
    id: '1',
    userRole: UserRole.civilian,
    locale: Language.english,
    roleIsConfirmed: true,
    devicesInfo: [deviceInfoModel],
    nickname: nicknameIncorrect,
  );
  static final deviceInfoModel = DeviceInfoModel(
    deviceId: deviceId,
    date: dateTime,
    build: 'test_build',
    platform: PlatformEnum.unknown,
    fcmToken: fcmToken,
  );
  static const deviceId = 'test_device_id';
  static const fcmToken = 'test_fcm_token';
  static const aPNSToken = 'APNS_token';
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
  static const translateModel = TranslateModel(
    uk: 'тест',
    en: 'text',
  );

  static final feedbackModel = FeedbackModel(
    id: '',
    guestId: user.id,
    guestName: nameCorrect,
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
    image: const ImageModel(downloadURL: image),
  );
  static final dateTime = DateTime(2024, 4, 12);
  static final nextDateTime = DateTime(2026, 10, 24);
  static final previousDateTime = DateTime(2024, 3, 12);
  static final dateTimeId = DateTime(0, 0, 0, 0, 1, 1, 1, 1);
  static const downloadURL = 'test_URL.test';
  static const id = '1';
  static const secondId = '2';

  static final discountModelItems = <DiscountModel>[
    for (var i = 0; i < _items; i++)
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

  static final cityModelItems = <CityModel>[
    for (var i = 0; i < 5; i++)
      CityModel(
        id: i.toString(),
        name: i == 0 ? translateModel : KMockText.discountModel.location!.first,
        region: KMockText.discountModel.location!.last,
      ),
  ];

  static final widgetSendDiscountModel = sendDiscountModel.copyWith(
    eligibility: [EligibilityEnum.all],
  );

  static final blocSendDiscountModel = sendDiscountModel.copyWith(
    eligibility: const [EligibilityEnum.all],
  );

  static final sendDiscountModel = discountModelItems.first.copyWith(
    // additionalDetails: null,
    // html: null,
    // territory: null,
    userId: fullCompanyModel.id,
    userName: fullCompanyModel.companyName,
    company: TranslateModel(uk: fullCompanyModel.publicName!),
    subLocation: null,
    userPhoto: null,
    phoneNumber: null,
    requirements: null,
    status: DiscountState.isNew,
    // subcategory: null,
    dateVerified: dateTime,
  );

  static final userDiscountModelItems = <DiscountModel>[
    for (var i = 0; i < 30; i++)
      KMockText.discountModel.copyWith(
        id: i.toString(),
        userId: userWithoutPhoto.id,
        dateVerified: dateTime,
      ),
  ];

  static final userDiscountModelItemsWidget = <DiscountModel>[
    for (var i = 0; i < 30; i++)
      KMockText.discountModel.copyWith(
        id: i.toString(),
        userId: userWithoutPhoto.id,
        dateVerified: dateTime,
        status: i == 0
            ? DiscountState.rejected
            : i == 4
                ? DiscountState.deactivated
                : DiscountState.published,
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
    for (var i = 0; i < _items; i++)
      KMockText.discountModel.copyWith(
        company: i == 0 ? null : KMockText.discountModel.company,
        expiration: i == 0 ? null : KMockText.discountModel.expiration,
        id: i.toString(),
        userId: i.toString(),
        category: i == 0
            ? List.generate(
                KMockText.tag.length,
                (index) => TranslateModel(uk: KMockText.tag.elementAt(index)),
              )
            : KMockText.discountModel.category,
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

  static final packageInfo = PackageInfo(
    appName: 'test',
    packageName: 'test',
    version: version,
    buildNumber: '1',
  );

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
        story: KMockText.cardData.substring(0, 250),
        userName: user.name,
        userId: user.id,
        userPhoto: i > _itemsPhoto ? userPhotoModel : null,
      ),
  ];

  // static final storyModelItems = <StoryModel>[
  //   for (var i = 0; i < _items; i++)
  //     StoryModel(
  //       id: i.toString(),
  //       date: dateTime,
  //       image: i > _itemsPhoto ? imageModels : null,
  //       story: KMockText.cardData.substring(0, 250),
  //       userName: user.name,
  //       userId: user.id,
  //       userPhoto: i > _itemsPhoto ? userPhotoModel : null,
  //     ),
  // ];
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
        message: field + field + field + field,
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
    noResume: false,
  );
  static const employeeRespondModelModel = EmployeeRespondModel(
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
  static NotificationSettings notificationSettings({
    AuthorizationStatus authorizationStatus = AuthorizationStatus.authorized,
  }) =>
      NotificationSettings(
        alert: AppleNotificationSetting.disabled,
        announcement: AppleNotificationSetting.disabled,
        authorizationStatus: authorizationStatus,
        badge: AppleNotificationSetting.disabled,
        carPlay: AppleNotificationSetting.disabled,
        lockScreen: AppleNotificationSetting.disabled,
        notificationCenter: AppleNotificationSetting.disabled,
        showPreviews: AppleShowPreviewSetting.never,
        timeSensitive: AppleNotificationSetting.disabled,
        criticalAlert: AppleNotificationSetting.disabled,
        sound: AppleNotificationSetting.disabled,
      );
  static final linkModel = LinkModel(
    id: id,
    userId: user.id,
    link: link,
    date: dateTime,
  );
  static final linkModelWrong = LinkModel(
    id: id,
    userId: user.id,
    link: '$link$field',
    date: dateTime,
  );
  static const link = 'https://veteranam.info/';
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
  static const scrollingUp250 = Offset(0, 250);
  static const scrollingUp500 = Offset(0, 500);
  static const scrollingUp1000 = Offset(0, 1000);
  static const scrollingUp1500 = Offset(0, 1500);

  static const windowDeskSize = Size(1700, 1700);
  static const windowMobileSize = Size(700, 700);
  static const windowSmallSize = Size(500, 500);
  static const windowVerySmallSize = Size(460, 460);

  static const englishIndex = 1;
  static const ukrainIndex = 0;

  static Future<void> get delay async =>
      // ignore: inference_failure_on_instance_creation
      Future.delayed(const Duration(microseconds: 1));
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
  static const userRole = 'User Role Screen';
  static const discountsAdd = 'Discounts Add Screen';
  static const discountsEdit = 'Discounts Edit Screen';
  static const businessDashboard = 'Business Dashboard Screen';
  static const pwResetEmail = 'Password Reset Email Screen';
  static const passwordReset = 'Password Reset Screen';
  static const company = 'Company Screen';

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
  static const build = 'Build';
  static const device = 'Device';
  static const dataPicker = 'Data Picker';

  static const report = 'Report Dialog';
  static const privacyPolicy = 'Privacy Policy Dialog';
  static const discountCard = 'Discount Card Dialog';
  static const newsCard = 'News Card Dialog';

  static const prod = 'PROD';
  static const dev = 'DEV';
  static const mobile = 'MOBILE $prod';
}
