import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@singleton
class NetworkRepository {
  NetworkRepository(
    this.appNetworkRepository,
  ) {
    _networkStatuscontroller = StreamController<NetworkStatus>.broadcast(
      onListen: _onListConnectivityResultStreamListen,
      onCancel: _onListConnectivityResultStreamCancel,
    );
  }

  final IAppNetworkRepository appNetworkRepository;
  late StreamController<NetworkStatus> _networkStatuscontroller;
  StreamSubscription<List<ConnectivityResult>>?
      _listConnectivityResultSubscription;

  void _onListConnectivityResultStreamListen() {
    _listConnectivityResultSubscription ??=
        appNetworkRepository.connectivityResults.listen((connectivityResults) {
      if (connectivityResults.hasNetwork) {
        _networkStatuscontroller.add(NetworkStatus.network);
      } else {
        _networkStatuscontroller.add(NetworkStatus.offline);
      }
    });
  }

  void _onListConnectivityResultStreamCancel() {
    _listConnectivityResultSubscription?.cancel();
    _listConnectivityResultSubscription = null;
  }

  Stream<NetworkStatus> get status => _networkStatuscontroller.stream;

  NetworkStatus get currentNetwork {
    final connectivityResults = appNetworkRepository.currentConnectivityResults;
    if (connectivityResults.hasNetwork) {
      return NetworkStatus.network;
    } else {
      return NetworkStatus.offline;
    }
  }

  // @disposeMethod
  void dispose() {
    _networkStatuscontroller.close();
    _listConnectivityResultSubscription?.cancel();
  }
}
