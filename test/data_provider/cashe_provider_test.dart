import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/shared/data_provider/cache_provider.dart';
import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.casheClient} ', () {
    group(' ${KGroupText.provider} ', () {
      late CacheClient cashe;
      setUp(() async {
        cashe = CacheClient();
      });

      test('cashe client', () async {
        cashe.write(key: KTestVariables.token, value: KTestVariables.field);
        late var value = cashe.read(key: KTestVariables.token);
        expect(value, KTestVariables.field);
        cashe.clear();
        value = cashe.read(key: KTestVariables.token);
        expect(value, isNot(KTestVariables.field));
      });
    });
  });
}
