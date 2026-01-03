import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IStorage)
class SecureStorageRepository implements IStorage {
  SecureStorageRepository({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;
  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> readOne({required String keyItem}) async {
    return _secureStorage.read(key: keyItem);
  }

  @override
  Future<bool> writeOne({
    required String keyItem,
    required String valueItem,
  }) async {
    await _secureStorage.write(key: keyItem, value: valueItem);
    final result = await readOne(keyItem: keyItem);
    if (result == keyItem) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
