import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

/// A singleton class that implements the [IAppNetworkRepository] interface.
/// This class is responsible for monitoring network connectivity and caching
/// the results.
@Singleton(as: IAppNetworkRepository)
class AppNetworkRepository implements IAppNetworkRepository {
  /// Constructor for [AppNetworkRepository].
  /// Takes [Connectivity] and [CacheClient] as dependencies.
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
    // ignore: unused_local_variable
    final connectivityResults = currentConnectivityResults.isEmpty;
  }

  /// Checks if the internet connection is slow based on a threshold for
  /// response time.
  bool _isSlowCached = false;
  DateTime _lastSpeedCheckTime = DateTime.fromMillisecondsSinceEpoch(0);

  // Check for slow connection and cache the result.
  @override
  Future<bool> isSlow() async {
    const slowThreshold = Duration(milliseconds: 300);
    const cacheDuration = Duration(seconds: 30); // Cache result for 30 seconds

    final currentTime = DateTime.now();
    if (currentTime.difference(_lastSpeedCheckTime) < cacheDuration) {
      return _isSlowCached;
    }

    try {
      final stopwatch = Stopwatch()..start();
      await InternetAddress.lookup('example.com');
      stopwatch.stop();
      _isSlowCached = stopwatch.elapsed > slowThreshold;
    } catch (_) {
      _isSlowCached = false;
    }

    _lastSpeedCheckTime = currentTime;
    return _isSlowCached;
  }

  // Synchronous check using the cached result.
  @override
  bool isSlowSync() {
    const cacheDuration =
        Duration(seconds: 30); // Same cache duration as async check
    final currentTime = DateTime.now();

    // If the cache is still valid, return the cached value.
    if (currentTime.difference(_lastSpeedCheckTime) < cacheDuration) {
      return _isSlowCached;
    }

    // If the cache is outdated, return false
    return false;
  }
}
