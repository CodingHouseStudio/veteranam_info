import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
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

    test('Value Error Helper', () async {
      final result = valueErrorHelper(
        () {
          throw Exception(KGroupText.failure);
        },
        failureValue: KGroupText.failure,
        methodName: KTestVariables.field,
        className: KTestVariables.field,
      );

      expect(
        result,
        KGroupText.failure,
      );
    });

    test('Value Future Error Helper', () async {
      final result = await valueFutureErrorHelper(
        () async {
          throw Exception(KGroupText.failure);
        },
        failureValue: KGroupText.failure,
        methodName: KTestVariables.field,
        className: KTestVariables.field,
      );

      expect(
        result,
        KGroupText.failure,
      );
    });
  });
}
