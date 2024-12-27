import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.authentication}'
      ' ${KGroupText.model} User', () {
    test('check is Empty ', () {
      expect(
        KTestVariables.user.isEmpty,
        isFalse,
      );

      expect(
        User.empty.isEmpty,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestVariables.user.isNotEmpty,
        isTrue,
      );

      expect(
        User.empty.isNotEmpty,
        isFalse,
      );
    });
    final fullJson = {
      UserModelJsonField.id: KTestVariables.user.id,
      UserModelJsonField.email: KTestVariables.user.email,
      UserModelJsonField.name: KTestVariables.user.name,
      UserModelJsonField.photo: KTestVariables.user.photo,
      UserModelJsonField.phoneNumber: KTestVariables.user.phoneNumber,
    };
    final nullableJson = {
      UserModelJsonField.id: KTestVariables.user.id,
      UserModelJsonField.email: null,
      UserModelJsonField.name: null,
      UserModelJsonField.photo: null,
      UserModelJsonField.phoneNumber: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final user = User.fromJson(fullJson);

        expect(user.id, KTestVariables.user.id);
        expect(user.email, KTestVariables.user.email);
        expect(user.name, KTestVariables.user.name);
        expect(user.phoneNumber, KTestVariables.user.phoneNumber);
        expect(user.photo, KTestVariables.user.photo);
      });
      test('${KGroupText.nullable} ', () {
        final user = User.fromJson(nullableJson);

        expect(user.id, KTestVariables.user.id);
        expect(user.email, isNull);
        expect(user.name, isNull);
        expect(user.phoneNumber, isNull);
        expect(user.photo, isNull);
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          UserModelJsonField.email: KTestVariables.user.email,
          UserModelJsonField.name: KTestVariables.user.name,
          UserModelJsonField.photo: KTestVariables.user.photo,
          UserModelJsonField.phoneNumber: KTestVariables.user.phoneNumber,
        };

        expect(
          () => User.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final userModelJson = KTestVariables.user.toJson();

        expect(userModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final userModelJson = User(id: KTestVariables.user.id).toJson();

        expect(userModelJson, nullableJson);
      });
    });
  });
}
