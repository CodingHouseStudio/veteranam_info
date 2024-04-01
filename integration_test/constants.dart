import 'dart:ui';

import 'package:kozak/shared/shared.dart';

// const String usernameCorrectIntegrationTest = 'andreytest@gmail.com';
// const String passwordCorrectIntegrationTest = 'qwerty';
// String randomUsername = generateRandomUsername();
// String randomPassword = 'qwerty';

Future<void> setUpGlobalIntegration() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // if (kIsWeb) {
  //   usePathUrlStrategy();
  // }

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
}
