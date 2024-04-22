import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@LazySingleton(as: IStorage)
class SecureStorageRepository implements IStorage {
  SecureStorageRepository();

  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
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
