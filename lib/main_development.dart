import 'package:firebase_core/firebase_core.dart';
import 'package:kozak/app.dart';
import 'package:kozak/bootstrap.dart';
import 'package:kozak/firebase_options_development.dart';

/// COMMENT: Our main file
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  await bootstrap(App.new);
}
