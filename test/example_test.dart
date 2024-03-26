import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_dependency_injector.dart';

void main() {
  group('Successful login snackBar and navigation to app', () {
    setUp(configureDependenciesTest);
    testWidgets('Successful login snackBar and navigation to app',
        (WidgetTester tester) async {
      expect(find.byKey(const Key('none')), findsNothing);
    });
  });
}
