import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:veteranam/firebase_options_development.dart' as dev;
import 'package:veteranam/firebase_options_development.dart' as prod;
import 'package:veteranam/shared/shared.dart';

// const String usernameCorrectIntegrationTest = 'andreytest@gmail.com';
// const String passwordCorrectIntegrationTest = 'qwerty';
// String randomUsername = generateRandomUsername();
// String randomPassword = 'qwerty';
/// COMMENT: Method sets setting for integration tests
Future<void> setUpGlobalIntegration() async {
  await Firebase.initializeApp(
    options: Config.isDevelopment
        ? dev.DefaultFirebaseOptions.currentPlatform
        : prod.DefaultFirebaseOptions.currentPlatform,
    name: kIsWeb ? null : 'TEST',
  );

  if (kIsWeb) {
    usePathUrlStrategy();
  }

  // FlutterError.onError = (details) {
  //   dev.log(details.exceptionAsString(), stackTrace: details.stack);
  // };
  //
  // Bloc.observer = const AppBlocObserver();

  configureDependencies();
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

abstract class KTestText {
  static const String useremail = 'example@gmail.com';

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

  static Key getFooterKey(String routeName) {
    // Using a Map instead of a switch statement because Dart does not allow
    // accessing
    // properties of an object (e.g., routeName) in constant expressions within
    // a switch case.
    final routeKeys = <String, Key>{
      KRoute.aboutUs.name: KWidgetkeys.screen.aboutUs.screen,
      KRoute.support.name: KWidgetkeys.screen.investors.screen,
      KRoute.stories.name: KWidgetkeys.screen.story.screen,
      KRoute.discounts.name: KWidgetkeys.screen.discounts.screen,
      KRoute.login.name: KWidgetkeys.screen.login.screen,
      KRoute.work.name: KWidgetkeys.screen.work.screen,
      KRoute.information.name: KWidgetkeys.screen.information.screen,
      KRoute.consultation.name: KWidgetkeys.screen.consultation.screen,
    };

    return routeKeys[routeName] ?? const Key('');
  }

  static Key getMobNavigationKey(String routeName) {
    // Using a Map instead of a switch statement because Dart does not allow
    // accessing
    // properties of an object (e.g., routeName) in constant expressions within
    // a switch case.
    final routeKeys = <String, Key>{
      KRoute.support.name: KWidgetkeys.widget.mobNavigation.investors,
      KRoute.home.name: KWidgetkeys.widget.mobNavigation.settings,
    };

    return routeKeys[routeName] ?? const Key('');
  }
}
