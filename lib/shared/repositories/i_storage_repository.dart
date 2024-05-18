import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IStorage {
  Future<String?> readOne({required String keyItem});

  Future<bool> writeOne({
    required String keyItem,
    required String valueItem,
  });

  Future<void> deleteAll();

  dynamic get secureStorage;
  @visibleForTesting
  set secureStorage(dynamic setSecureStorage);
}
