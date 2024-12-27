import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('City ${KGroupText.model} ', () {
    final fullJson = {
      CitiesModelJsonField.id: KTestVariables.cityModelItems.first.id,
      CitiesModelJsonField.region:
          KTestVariables.cityModelItems.first.region.toJson(),
      CitiesModelJsonField.name:
          KTestVariables.cityModelItems.first.name.toJson(),
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final cityModel = CityModel.fromJson(fullJson);

        expect(
          cityModel.id,
          KTestVariables.cityModelItems.first.id,
        );
        expect(
          cityModel.region,
          KTestVariables.cityModelItems.first.region,
        );
        expect(
          cityModel.name,
          KTestVariables.cityModelItems.first.name,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          CitiesModelJsonField.region:
              KTestVariables.cityModelItems.first.region,
          CitiesModelJsonField.name: KTestVariables.cityModelItems.first.name,
        };

        expect(
          () => CityModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final cityModelJson = KTestVariables.cityModelItems.first.toJson();

        expect(cityModelJson, fullJson);
      });
    });
  });
}
