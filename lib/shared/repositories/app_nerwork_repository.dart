import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;

/// A singleton class that implements the [IAppNetworkRepository] interface.
/// This class is responsible for monitoring network connectivity and caching
/// the results.
@Singleton(as: IAppNetworkRepository)
class AppNetworkRepository implements IAppNetworkRepository {
  /// Constructor for [AppNetworkRepository].
  /// Takes [Connectivity] and [CacheClient] as dependencies.
  AppNetworkRepository({
    required Connectivity connectivity,
    required CacheClient cache,
  })  : _connectivity = connectivity,
        _cache = cache {
    _updateAuthStatusBasedOnCache();
  }

  final Connectivity _connectivity;
  final CacheClient _cache;

  @visibleForTesting
  static const connectivityCacheKey = '__connectivity_cache_key__';

  /// A stream of [ConnectivityResult] which emits network connectivity changes.
  /// Caches the results if they are not empty, otherwise returns
  /// [ConnectivityResult.none].
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

  /// Retrieves the current [ConnectivityResult] from the cache.
  /// If the cache is empty, returns [ConnectivityResult.none].
  @override
  List<ConnectivityResult> get currentConnectivityResults =>
      _cache.read<List<ConnectivityResult>>(key: connectivityCacheKey) ??
      [ConnectivityResult.wifi];

  /// Updates the authentication status based on the cached connectivity
  /// results.
  void _updateAuthStatusBasedOnCache() {
    final connectivityResults = currentConnectivityResults.isEmpty;
    log('current connection - $connectivityResults');
  }
}
