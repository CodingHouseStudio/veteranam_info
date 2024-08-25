import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IStorage)
class SecureStorageRepository implements IStorage {
  SecureStorageRepository();
  // coverage:ignore-start
  late FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  // coverage:ignore-end

  @override
  FlutterSecureStorage get secureStorage => _secureStorage;

  @visibleForTesting
  @override
  set secureStorage(FlutterSecureStorage setSecureStorage) =>
      _secureStorage = setSecureStorage;

  @override
  Future<String?> readOne({required String keyItem}) async {
    return secureStorage.read(key: keyItem);
  }

  @override
  Future<bool> writeOne({
    required String keyItem,
    required String valueItem,
  }) async {
    await secureStorage.write(key: keyItem, value: valueItem);
    final result = await readOne(keyItem: keyItem);
    if (result == keyItem) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }
}
