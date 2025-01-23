import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Some Failure ${KGroupText.model} ', () {
    test('${KGroupText.initial} ', () {
      final filterModel = SomeFailure.value(
        error: KGroupText.failure,
      );

      expect(filterModel, SomeFailure.serverError);
    });

    test('Either Helper', () {
      final result = eitherHelper<bool>(
        () {
          throw Exception(KGroupText.failure);
        },
        methodName: KTestVariables.field,
        className: KTestVariables.field,
      );

      expect(
        result,
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          SomeFailure.serverError,
        ),
      );
    });

    test('Either Future Helper', () async {
      final result = await eitherFutureHelper<bool>(
        () async {
          throw Exception(KGroupText.failure);
        },
        methodName: KTestVariables.field,
        className: KTestVariables.field,
      );

      expect(
        result,
        isA<Left<SomeFailure, bool>>().having(
          (e) => e.value,
          'value',
          SomeFailure.serverError,
        ),
      );
    });

    test('Bool Error Helper', () async {
      final result = boolErrorHelper(
        () {
          throw Exception(KGroupText.failure);
        },
        methodName: KTestVariables.field,
        className: KTestVariables.field,
      );

      expect(
        result,
        false,
      );
    });
  });
}
