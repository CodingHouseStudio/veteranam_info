import 'package:get_it/get_it.dart';

/// For Register Bloc
void registerFactory<T extends Object>(T Function() bloc) {
  if (GetIt.I.isRegistered<T>()) {
    GetIt.I.unregister<T>();
  }
  GetIt.I.registerFactory<T>(
    () => bloc(),
  );
}

/// For Register Bloc
void registerFactoryParam<T extends Object, S, P>(
  T Function(S par1, P par2) bloc,
) {
  if (GetIt.I.isRegistered<T>()) {
    GetIt.I.unregister<T>();
  }
  GetIt.I.registerFactoryParam<T, S, P>(
    (par1, par2) => bloc(par1, par2),
  );
}
