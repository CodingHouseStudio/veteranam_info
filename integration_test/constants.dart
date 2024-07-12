import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:veteranam/firebase_options_development.dart';
import 'package:veteranam/shared/shared.dart';

// const String usernameCorrectIntegrationTest = 'andreytest@gmail.com';
// const String passwordCorrectIntegrationTest = 'qwerty';
// String randomUsername = generateRandomUsername();
// String randomPassword = 'qwerty';
/// COMMENT: Method sets setting for integration tests
Future<void> setUpGlobalIntegration() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
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
  static const scrolling = Offset(0, -40000);

  static const windowMobileSize = Size(800, 800);

  static final screens = [
    KWidgetkeys.screen.aboutUs.screen,
    KWidgetkeys.screen.investors.screen,
    // KWidgetkeys.screen.contact.screen,
    KWidgetkeys.screen.story.screen,
    KWidgetkeys.screen.discounts.screen,
    KWidgetkeys.screen.login.screen,
    KWidgetkeys.screen.work.screen,
    KWidgetkeys.screen.information.screen,
    KWidgetkeys.screen.consultation.screen,
  ];
}

abstract class KTestText {
  static const String footer = 'Контакти\n';

  static const String useremail = 'example@gmail.com';
}
