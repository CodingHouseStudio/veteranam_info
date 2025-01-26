import 'package:get_it/get_it.dart';

/// For Register Repository
void registerSingleton<T extends Object>(T bloc) {
  if (GetIt.I.isRegistered<T>()) {
    GetIt.I.unregister<T>();
  }
  GetIt.I.registerSingleton<T>(
    bloc,
  );
}
