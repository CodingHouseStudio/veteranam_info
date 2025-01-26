import 'package:get_it/get_it.dart';

/// For Register Repository
void registerSingleton<T extends Object>(T repository) {
  if (GetIt.I.isRegistered<T>()) {
    GetIt.I.unregister<T>();
  }
  GetIt.I.registerSingleton<T>(
    repository,
  );
}

/// For Register Repository
// void registerLazySingleton<T extends Object>(T Function() repository) {
//   if (GetIt.I.isRegistered<T>()) {
//     GetIt.I.unregister<T>();
//   }
//   GetIt.I.registerLazySingleton<T>(
//     repository,
//   );
// }
