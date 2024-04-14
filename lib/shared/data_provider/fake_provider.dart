import 'package:injectable/injectable.dart';

/// COMMENT: Class for caching data in tests
@Singleton()
class FakeClient {
  FakeClient();

  Future<Map<String, dynamic>> get() async {
    try {
      return _auditExample;
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  static const Map<String, dynamic> _auditExample = {
    'id': '1',
    'title': 'Fire Safety Inspection',
    'date': '2024-02-08T12:00:00Z',
    'status': 'Completed',
  };
}
