import 'package:firebase_core_platform_interface/test.dart';
// ignore: depend_on_referenced_packages

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

/// COMMENT: Method adds mock Firebase in tests
void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(minutes: 5));
  }
}
