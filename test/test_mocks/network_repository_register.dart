import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

late StreamController<List<ConnectivityResult>> networkController;
ConnectivityResult network = ConnectivityResult.mobile;

void networkRepositoryInit() {
  final IAppNetworkRepository mockAppNetworkRepository =
      MockIAppNetworkRepository();
  networkController = StreamController<List<ConnectivityResult>>.broadcast()
    ..add([network]);
  when(mockAppNetworkRepository.connectivityResults).thenAnswer(
    (realInvocation) => networkController.stream,
  );
  when(mockAppNetworkRepository.currentConnectivityResults).thenAnswer(
    (realInvocation) => [network],
  );
  if (GetIt.I.isRegistered<IAppNetworkRepository>()) {
    GetIt.I.unregister<IAppNetworkRepository>();
  }
  GetIt.I.registerSingleton<IAppNetworkRepository>(mockAppNetworkRepository);
}
