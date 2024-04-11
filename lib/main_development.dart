import 'package:firebase_core/firebase_core.dart';
import 'package:kozak/app.dart';
import 'package:kozak/bootstrap.dart';
import 'package:kozak/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(() => const App());
}
