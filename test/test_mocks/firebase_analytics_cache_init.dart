import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void firebaseAnalyticsCacheInit() {
  final SharedPrefencesProvider mockSharedPrefencesProvider =
      MockSharedPrefencesProvider();
  final firebaseAnalyticsCacheController = FirebaseAnalyticsCacheController(
    sharedPrefencesProvider: mockSharedPrefencesProvider,
  );

  when(
    firebaseAnalyticsCacheController.consentDialogShowed,
  ).thenAnswer(
    (realInvocation) => true,
  );

  if (GetIt.I.isRegistered<FirebaseAnalyticsCacheController>()) {
    GetIt.I.unregister<FirebaseAnalyticsCacheController>();
  }
  GetIt.I.registerSingleton<FirebaseAnalyticsCacheController>(
    firebaseAnalyticsCacheController,
  );
}
