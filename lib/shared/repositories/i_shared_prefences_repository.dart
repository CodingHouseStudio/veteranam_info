abstract class ISharedPrefencesRepository {
  Future<bool> setString({required String key, required String value});
  String? getString(String key);
  Future<bool> setStringList({
    required String key,
    required List<String> value,
  });
  List<String>? getStringList(String key);
}
