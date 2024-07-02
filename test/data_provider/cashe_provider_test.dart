import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';

void main() {
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
