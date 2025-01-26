import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.secureStorage} ', () {
    group(' ${KGroupText.repository} ', () {
      late IStorage storage;
      late FlutterSecureStorage mockFlutterSecureStorage;
      group('${KGroupText.successfulSet} ', () {
        setUp(() {
          mockFlutterSecureStorage = MockFlutterSecureStorage();
          when(mockFlutterSecureStorage.read(key: KTestVariables.key))
              .thenAnswer(
            (_) async => KTestVariables.key,
          );
          when(
            mockFlutterSecureStorage.write(
              key: KTestVariables.key,
              value: KTestVariables.field,
            ),
          ).thenAnswer(
            (_) async {},
          );
          when(mockFlutterSecureStorage.deleteAll()).thenAnswer(
            (_) async => {},
          );

          storage =
              SecureStorageRepository(secureStorage: mockFlutterSecureStorage);
        });
        test('read one', () async {
          expect(
            await storage.readOne(keyItem: KTestVariables.key),
            KTestVariables.key,
          );
        });
        test('write one(true)', () async {
          final result = await storage.writeOne(
            keyItem: KTestVariables.key,
            valueItem: KTestVariables.field,
          );

          verify(
            mockFlutterSecureStorage.write(
              key: KTestVariables.key,
              value: KTestVariables.field,
            ),
          ).called(1);

          expect(
            result,
            isTrue,
          );
        });
        test('write one(false)', () async {
          final result = await storage.writeOne(
            keyItem: KTestVariables.field,
            valueItem: KTestVariables.field,
          );

          verify(
            mockFlutterSecureStorage.write(
              key: KTestVariables.field,
              value: KTestVariables.field,
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
