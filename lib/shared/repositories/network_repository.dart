import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

enum NetworkStatus {
  network,
  offline,
  slow,
}

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
    _listConnectivityResultSubscription ??= appNetworkRepository
        .connectivityResults
        .listen((connectivityResults) async {
      if (connectivityResults.hasNetwork) {
        final isSlow = await appNetworkRepository.isSlow();
        if (isSlow) {
          _networkStatuscontroller.add(NetworkStatus.slow);
        } else {
          _networkStatuscontroller.add(NetworkStatus.network);
        }
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
      if (appNetworkRepository.isSlowSync()) {
        // Assuming a synchronous check
        return NetworkStatus.slow;
      }
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
