import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@LazySingleton(as: IStorage)
class SecureStorageRepository implements IStorage {
  SecureStorageRepository();
  late dynamic? _secureStorage;

  @override
  dynamic get secureStorage => _secureStorage ?? dynamic;

  @visibleForTesting
  @override
  set secureStorage(dynamic setSecureStorage) =>
      _secureStorage = setSecureStorage;

  @override
  Future<String?> readOne({required String keyItem}) async {
    return '243';
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
