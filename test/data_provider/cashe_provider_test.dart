import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.casheClient} ', () {
    group(' ${KGroupText.provider} ', () {
      late CacheClient cashe;
      setUp(() async {
        cashe = CacheClient();
      });

      test('cashe client', () async {
        cashe.write(key: KTestText.token, value: KTestText.field);
        late var value = cashe.read(key: KTestText.token);
        expect(value, KTestText.field);
        cashe.clear();
        value = cashe.read(key: KTestText.token);
        expect(value, isNot(KTestText.field));
      });
    });
  });
}
