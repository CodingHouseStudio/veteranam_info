import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.appAuthentication} ${KGroupText.model} User', () {
    test('check is Empty ', () {
      expect(
        KTestText.user.isAnonymously,
        isFalse,
      );

      expect(
        User.empty.isAnonymously,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestText.user.isNotAnonymously,
        isTrue,
      );

      expect(
        User.empty.isNotAnonymously,
        isFalse,
      );
    });
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.user.id,
          'email': KTestText.user.email,
          'name': KTestText.user.name,
          'photo': KTestText.user.photo,
          'phoneNumber': KTestText.user.phoneNumber,
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
          'id': KTestText.user.id,
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
          'email': KTestText.user.email,
          'name': KTestText.user.name,
          'photo': KTestText.user.photo,
          'phoneNumber': KTestText.user.phoneNumber,
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
          'id': KTestText.user.id,
          'email': KTestText.user.email,
          'name': KTestText.user.name,
          'photo': KTestText.user.photo,
          'phoneNumber': KTestText.user.phoneNumber,
        };

        final userModelJson = KTestText.user.toJson();

        expect(userModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.user.id,
          'email': null,
          'name': null,
          'photo': null,
          'phoneNumber': null,
        };

        final userModelJson = User(id: KTestText.user.id).toJson();

        expect(userModelJson, json);
      });
    });
  });
}
