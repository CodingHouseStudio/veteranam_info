import 'package:firebase_core/firebase_core.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_development.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  await bootstrap(App.new);
}
