import 'dart:ui';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'package:kozak/shared/shared.dart';

// const String usernameCorrectIntegrationTest = 'andreytest@gmail.com';
// const String passwordCorrectIntegrationTest = 'qwerty';
// String randomUsername = generateRandomUsername();
// String randomPassword = 'qwerty';

Future<void> setUpGlobalIntegration() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

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
  static const scrolling = Offset(0, -500);

  static const windowTabletSize = Size(1500, 1500);

  static const windowMobileSize = Size(800, 800);
}

abstract class KTestText {
  static const String footer = 'Контакти\n';

  static const String useremail = 'example@gmail.com';
}
