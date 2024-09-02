import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.authentication}'
      ' ${KGroupText.model} User', () {
    test('check is Empty ', () {
      expect(
        KTestText.user.isEmpty,
        isFalse,
      );

      expect(
        User.empty.isEmpty,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestText.user.isNotEmpty,
        isTrue,
      );

      expect(
        User.empty.isNotEmpty,
        isFalse,
      );
    });
    final fullJson = {
      UserModelJsonField.id: KTestText.user.id,
      UserModelJsonField.email: KTestText.user.email,
      UserModelJsonField.name: KTestText.user.name,
      UserModelJsonField.photo: KTestText.user.photo,
      UserModelJsonField.phoneNumber: KTestText.user.phoneNumber,
    };
    final nullableJson = {
      UserModelJsonField.id: KTestText.user.id,
      UserModelJsonField.email: null,
      UserModelJsonField.name: null,
      UserModelJsonField.photo: null,
      UserModelJsonField.phoneNumber: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final user = User.fromJson(fullJson);

        expect(user.id, KTestText.user.id);
        expect(user.email, KTestText.user.email);
        expect(user.name, KTestText.user.name);
        expect(user.phoneNumber, KTestText.user.phoneNumber);
        expect(user.photo, KTestText.user.photo);
      });
      test('${KGroupText.nullable} ', () {
        final user = User.fromJson(nullableJson);

        expect(user.id, KTestText.user.id);
        expect(user.email, isNull);
        expect(user.name, isNull);
        expect(user.phoneNumber, isNull);
        expect(user.photo, isNull);
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          UserModelJsonField.email: KTestText.user.email,
          UserModelJsonField.name: KTestText.user.name,
          UserModelJsonField.photo: KTestText.user.photo,
          UserModelJsonField.phoneNumber: KTestText.user.phoneNumber,
        };

        expect(
          () => User.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final userModelJson = KTestText.user.toJson();

        expect(userModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final userModelJson = User(id: KTestText.user.id).toJson();

        expect(userModelJson, nullableJson);
      });
    });
  });
}
