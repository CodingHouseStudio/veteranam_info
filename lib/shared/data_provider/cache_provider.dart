import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// COMMENT: Class for caching data
/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
@injectable
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    debugPrint('reading key: $key');
    final value = _cache[key];
    debugPrint('value: $value');
    if (value is T) return value;
    return null;
  }

  void clear() {
    _cache.clear();
  }
}
