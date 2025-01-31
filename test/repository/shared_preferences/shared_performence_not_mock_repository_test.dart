import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  // setUpAll(configureFailureDependenciesTest);

  // setUp(resetTestVariables);

  // tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.sharedPreferences} ${KGroupText.repository} ', () {
    group('Shared Preferences Not Mock', () {
      late ISharedPrefencesRepository sharedPrefencesRepository;
      setUp(() {
        TestWidgetsFlutterBinding.ensureInitialized();

        SharedPrefencesRepository.sharedPreferences = null;

        sharedPrefencesRepository = SharedPrefencesRepository();
      });
      test('Init Wait', () async {
        expect(
          await sharedPrefencesRepository.initWait(),
          false,
        );
      });
    });
  });
}
