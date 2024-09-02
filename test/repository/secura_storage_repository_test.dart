import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.secureStorage} ', () {
    group(' ${KGroupText.repository} ', () {
      late IStorage storage;
      late FlutterSecureStorage mockFlutterSecureStorage;
      group('${KGroupText.successfulSet} ', () {
        setUp(() {
          mockFlutterSecureStorage = MockFlutterSecureStorage();
          when(mockFlutterSecureStorage.read(key: KTestText.key)).thenAnswer(
            (_) async => KTestText.key,
          );
          when(
            mockFlutterSecureStorage.write(
              key: KTestText.key,
              value: KTestText.field,
            ),
          ).thenAnswer(
            (_) async {},
          );
          when(mockFlutterSecureStorage.deleteAll()).thenAnswer(
            (_) async => {},
          );
          storage = SecureStorageRepository()
            ..secureStorage = mockFlutterSecureStorage;
        });
        test('read one', () async {
          expect(
            await storage.readOne(keyItem: KTestText.key),
            KTestText.key,
          );
        });
        test('write one(true)', () async {
          final result = await storage.writeOne(
            keyItem: KTestText.key,
            valueItem: KTestText.field,
          );

          verify(
            mockFlutterSecureStorage.write(
              key: KTestText.key,
              value: KTestText.field,
            ),
          ).called(1);

          expect(
            result,
            isTrue,
          );
        });
        test('write one(false)', () async {
          final result = await storage.writeOne(
            keyItem: KTestText.field,
            valueItem: KTestText.field,
          );

          verify(
            mockFlutterSecureStorage.write(
              key: KTestText.field,
              value: KTestText.field,
            ),
          ).called(1);

          expect(
            result,
            isFalse,
          );
        });
        test('delete all', () async {
          await storage.deleteAll();

          verify(
            mockFlutterSecureStorage.deleteAll(),
          ).called(1);
        });
      });
    });
  });
}
