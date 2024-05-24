import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/models/models.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.appAuthentication} ${KGroupText.model} User', () {
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
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          UserModelJsonField.id: KTestText.user.id,
          UserModelJsonField.email: KTestText.user.email,
          UserModelJsonField.name: KTestText.user.name,
          UserModelJsonField.photo: KTestText.user.photo,
          UserModelJsonField.phoneNumber: KTestText.user.phoneNumber,
        };

        final user = User.fromJson(json);

        expect(user.id, KTestText.user.id);
        expect(user.email, KTestText.user.email);
        expect(user.name, KTestText.user.name);
        expect(user.phoneNumber, KTestText.user.phoneNumber);
        expect(user.photo, KTestText.user.photo);
      });
      test('${KGroupText.shouldBe} ', () {
        final json = {
          UserModelJsonField.id: KTestText.user.id,
        };

        final user = User.fromJson(json);

        expect(user.id, KTestText.user.id);
        expect(user.email, isNull);
        expect(user.name, isNull);
        expect(user.phoneNumber, isNull);
        expect(user.photo, isNull);
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          // id is missing
          UserModelJsonField.email: KTestText.user.email,
          UserModelJsonField.name: KTestText.user.name,
          UserModelJsonField.photo: KTestText.user.photo,
          UserModelJsonField.phoneNumber: KTestText.user.phoneNumber,
        };

        expect(
          () => UserSetting.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          UserModelJsonField.id: KTestText.user.id,
          UserModelJsonField.email: KTestText.user.email,
          UserModelJsonField.name: KTestText.user.name,
          UserModelJsonField.photo: KTestText.user.photo,
          UserModelJsonField.phoneNumber: KTestText.user.phoneNumber,
        };

        final userModelJson = KTestText.user.toJson();

        expect(userModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          UserModelJsonField.id: KTestText.user.id,
          UserModelJsonField.email: null,
          UserModelJsonField.name: null,
          UserModelJsonField.photo: null,
          UserModelJsonField.phoneNumber: null,
        };

        final userModelJson = User(id: KTestText.user.id).toJson();

        expect(userModelJson, json);
      });
    });
  });
}
