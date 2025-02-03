import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.sharedPreferences} ${KGroupText.repository} ', () {
    late ISharedPrefencesRepository sharedPrefencesRepository;
    late SharedPreferences mockSharedPreferences;
    setUp(() {
      mockSharedPreferences = MockSharedPreferences();

      sharedPrefencesRepository = SharedPrefencesRepository(
        sharedPreferences: mockSharedPreferences,
      );
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(mockSharedPreferences.getString(KTestVariables.key)).thenAnswer(
          (_) => KTestVariables.field,
        );
        when(
          mockSharedPreferences.setString(
            KTestVariables.key,
            KTestVariables.field,
          ),
        ).thenAnswer(
          (_) async => true,
        );
        when(mockSharedPreferences.getStringList(KTestVariables.key))
            .thenAnswer(
          (_) => KTestVariables.fieldList,
        );
        when(
          mockSharedPreferences.setStringList(
            KTestVariables.key,
            KTestVariables.fieldList,
          ),
        ).thenAnswer(
          (_) async => true,
        );
      });
      test('Get String', () async {
        expect(
          sharedPrefencesRepository.getString(KTestVariables.key),
          KTestVariables.field,
        );
      });
      test('Set String', () async {
        expect(
          await sharedPrefencesRepository.setString(
            key: KTestVariables.key,
            value: KTestVariables.field,
          ),
          true,
        );
      });
      test('Get String List', () async {
        expect(
          sharedPrefencesRepository.getStringList(KTestVariables.key),
          KTestVariables.fieldList,
        );
      });
      test('Set String List', () async {
        expect(
          await sharedPrefencesRepository.setStringList(
            key: KTestVariables.key,
            value: KTestVariables.fieldList,
          ),
          true,
        );
      });
    });

    group('${KGroupText.failure} ', () {
      setUp(() {
        mockSharedPreferences = MockSharedPreferences();
        when(mockSharedPreferences.getString(KTestVariables.key)).thenThrow(
          (_) => Exception(KGroupText.failure),
        );
        when(
          mockSharedPreferences.setString(
            KTestVariables.key,
            KTestVariables.field,
          ),
        ).thenThrow(
          (_) async => Exception(KGroupText.failure),
        );
        when(mockSharedPreferences.getStringList(KTestVariables.key)).thenThrow(
          (_) => Exception(KGroupText.failure),
        );
        when(
          mockSharedPreferences.setStringList(
            KTestVariables.key,
            KTestVariables.fieldList,
          ),
        ).thenThrow(
          (_) async => Exception(KGroupText.failure),
        );
      });
      test('Get String', () async {
        expect(
          sharedPrefencesRepository.getString(KTestVariables.key),
          null,
        );
      });
      test('Set String', () async {
        expect(
          await sharedPrefencesRepository.setString(
            key: KTestVariables.key,
            value: KTestVariables.field,
          ),
          false,
        );
      });
      test('Get String List', () async {
        expect(
          sharedPrefencesRepository.getStringList(KTestVariables.key),
          null,
        );
      });
      test('Set String List', () async {
        expect(
          await sharedPrefencesRepository.setStringList(
            key: KTestVariables.key,
            value: KTestVariables.fieldList,
          ),
          false,
        );
      });
    });
  });
}
