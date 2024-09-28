import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('City ${KGroupText.model} ', () {
    final fullJson = {
      CitiesModelJsonField.id: KTestText.cityModelItems.first.id,
      CitiesModelJsonField.region:
          KTestText.cityModelItems.first.region.toJson(),
      CitiesModelJsonField.name: KTestText.cityModelItems.first.name.toJson(),
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final cityModel = CityModel.fromJson(fullJson);

        expect(
          cityModel.id,
          KTestText.cityModelItems.first.id,
        );
        expect(
          cityModel.region,
          KTestText.cityModelItems.first.region,
        );
        expect(
          cityModel.name,
          KTestText.cityModelItems.first.name,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          CitiesModelJsonField.region: KTestText.cityModelItems.first.region,
          CitiesModelJsonField.name: KTestText.cityModelItems.first.name,
        };

        expect(
          () => CityModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final cityModelJson = KTestText.cityModelItems.first.toJson();

        expect(cityModelJson, fullJson);
      });
    });
  });
}
