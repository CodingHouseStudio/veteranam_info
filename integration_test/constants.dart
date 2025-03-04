import 'dart:developer' show log;
import 'dart:math' show Random;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/firebase_options_development.dart' as dev;
import 'package:veteranam/firebase_options_development.dart' as prod;
import 'package:veteranam/shared/helper/helper.dart';
import 'package:veteranam/shared/repositories/authentication_repository.dart';
import 'package:veteranam/shared/shared_flutter.dart';

// const String usernameCorrectIntegrationTest = 'andreytest@gmail.com';
// const String passwordCorrectIntegrationTest = 'qwerty';
// String randomUsername = generateRandomUsername();
// String randomPassword = 'qwerty';
/// COMMENT: Method sets setting for integration tests
Future<void> setUpGlobalIntegration() async {
  KTest.isInterationTest = true;
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: Config.isDevelopment
          ? dev.DefaultFirebaseOptions.currentPlatform
          : prod.DefaultFirebaseOptions.currentPlatform,
      name: Config.isWeb ? null : 'TEST',
    );
  }

  if (Config.isWeb) {
    usePathUrlStrategy();
  }

// Async exceptions handling
  PlatformDispatcher.instance.onError = (error, stack) {
    // Log the error details to FailureRepository with specified level and tags
    SomeFailure.value(
      error: error,
      stack: stack,
      tag: ErrorText.async, // Tag to identify async exceptions
      tagKey:
          ErrorText.mainFileKey, // Key for identifying error location/source
    );

    return true; // Return true to indicate the error has been handled
  };

// Set only Vertical orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (!Config.kIsWeb) {
    if (PlatformEnum.getPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  // FlutterError.onError = (details) {
  //   dev.log(details.exceptionAsString(), stackTrace: details.stack);
  // };
  //
  // Bloc.observer = const AppBlocObserver();
  await _asyncGetItRegister();

  await initializeDateFormatting();

  configureDependencies();

  final authRep = GetIt.I.get<AuthenticationRepository>();
  if (authRep.currectAuthenticationStatus ==
      AuthenticationStatus.authenticated) {
    await authRep.logOut();
  }
}

Future<void> tearDownGlobalIntegration() async {
  try {
    await GetIt.I.get<AuthenticationRepository>().logOut();
    await getIt.reset();
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  } catch (e, stack) {
    log(
      'Integration Tests Tear down error: ',
      error: e,
      stackTrace: stack,
    );
  }
}

Future<void> _asyncGetItRegister() async {
  final sharedPrefences = await SharedPreferences.getInstance();

  GetIt.I.registerSingleton(sharedPrefences);
}

// String generateRandomUsername() {
//   final timestamp = DateTime.now().millisecondsSinceEpoch;
//   final randomNumber = Random().nextInt(100000);
//   const salt = 'MyApp'; // Replace with your desired salt

//   return '$timestamp$randomNumber$salt@test.com';
// }

abstract class KTestConstants {
  static const scrollingDown = Offset(0, -10000);
  static const scrollingDown100 = Offset(0, -100);
  static const scrollingUp = Offset(0, 10000);
  static const scrollingUp200 = Offset(0, 200);
  static const scrollingUp500 = Offset(0, 500);
  static const scrollingUp1000 = Offset(0, 1000);
  static const scrollingUp1500 = Offset(0, 1500);

  static const windowDeskSize = Size(1700, 1700);
  static const windowMobileSize = Size(700, 700);

  static const englishIndex = 1;
  static const ukrainIndex = 0;
}

abstract class KTestVariables {
  static const String sgignInEmail = 'test@gmail.com';
  static const String signInUpPassword = 'Veteranam123!';

  static String get signUpEmail => _generateRandomUsername();

  static String _generateRandomUsername() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomNumber = Random().nextInt(100000);
    const salt = 'MyApp'; // Replace with your desired salt

    return '$timestamp$randomNumber$salt@test.com';
  }

  static const filter = 'filter_test';
  static const key = 'key_test';

  static const usernameCorrect = 'testUsername';
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
  static const link = 'https://veteranam.info/';
  static const companyCode = '12345678';

  static Key getFooterKey(String routeName) {
    // Using a Map instead of a switch statement because Dart does not allow
    // accessing
    // properties of an object (e.g., routeName) in constant expressions within
    // a switch case.
    final routeKeys = <String, Key>{
      KRoute.aboutUs.name: AboutUsKeys.screen,
      KRoute.support.name: InvestorsKeys.screen,
      KRoute.stories.name: StoryKeys.screen,
      KRoute.discounts.name: DiscountsKeys.screen,
      KRoute.login.name: LoginKeys.screen,
      KRoute.work.name: WorkKeys.screen,
      KRoute.information.name: InformationKeys.screen,
      KRoute.consultation.name: ConsultationKeys.screen,
    };

    return routeKeys[routeName] ?? const Key('');
  }

  static Key getMobNavigationKey(String routeName) {
    // Using a Map instead of a switch statement because Dart does not allow
    // accessing
    // properties of an object (e.g., routeName) in constant expressions within
    // a switch case.
    final routeKeys = <String, Key>{
      KRoute.support.name: MobNavigationKeys.investors,
      KRoute.home.name: MobNavigationKeys.settings,
    };

    return routeKeys[routeName] ?? const Key('');
  }
}
