import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('Cities ${KGroupText.repository} ', () {
    late ICitiesRepository citiesRepostory;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(mockFirestoreService.getCities()).thenAnswer(
          (_) async => KTestText.cityModelItems
              .sublist(1, KTestText.cityModelItems.length),
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        citiesRepostory = CitiesRepository();
      });
      test('questions', () async {
        expect(
          await citiesRepostory.getCities(),
          isA<Right<SomeFailure, List<CityModel>>>().having(
            (e) => e.value,
            'value',
            KTestText.cityModelItems
                .sublist(1, KTestText.cityModelItems.length),
          ),
        );
      });
    });
    group('${KGroupText.failure} ', () {
      setUp(() {
        when(mockFirestoreService.getCities())
            .thenThrow(Exception(KGroupText.failureGet));
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        citiesRepostory = CitiesRepository();
      });
      test('Get questions', () async {
        expect(
          await citiesRepostory.getCities(),
          isA<Left<SomeFailure, List<CityModel>>>(),
        );
      });
    });
    group('${KGroupText.firebaseFailure} ', () {
      setUp(() {
        when(mockFirestoreService.getCities())
            .thenThrow(FirebaseException(plugin: KGroupText.failureGet));
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);
        citiesRepostory = CitiesRepository();
      });
      test('Get questions', () async {
        expect(
          await citiesRepostory.getCities(),
          isA<Left<SomeFailure, List<CityModel>>>(),
        );
      });
    });
  });
}
