import 'package:connectivity_plus/connectivity_plus.dart';

abstract class IAppNetworkRepository {
  Stream<List<ConnectivityResult>> get connectivityResults;

  List<ConnectivityResult> get currentConnectivityResults;

  Future<bool> isSlow();

  bool isSlowSync();
}
