import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IAppNetworkRepository)
class AppNetworkRepository implements IAppNetworkRepository {
  AppNetworkRepository(
    this._connectivity,
    this._cache,
  ) {
    _updateAuthStatusBasedOnCache();
  }

  final Connectivity _connectivity;
  final CacheClient _cache;

  @visibleForTesting
  static const connectivityCacheKey = '__connectivity_cache_key__';

  @override
  Stream<List<ConnectivityResult>> get connectivityResults =>
      _connectivity.onConnectivityChanged.map(
        (connectivityResults) {
          if (connectivityResults.isNotEmpty) {
            _cache.write(key: connectivityCacheKey, value: connectivityResults);
            return connectivityResults;
          } else {
            return [ConnectivityResult.none];
          }
        },
      );

  @override
  List<ConnectivityResult> get currentConnectivityResults =>
      _cache.read<List<ConnectivityResult>>(key: connectivityCacheKey) ??
      [ConnectivityResult.none];

  void _updateAuthStatusBasedOnCache() {
    // ignore: unused_local_variable
    final connectivityResults = currentConnectivityResults.isEmpty;
  }
}
