abstract class IStorage {
  Future<String?> readOne({required String keyItem});

  Future<bool> writeOne({
    required String keyItem,
    required String valueItem,
  });

  Future<void> deleteAll();
}
