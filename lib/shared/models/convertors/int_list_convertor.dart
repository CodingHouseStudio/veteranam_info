import 'package:freezed_annotation/freezed_annotation.dart';

class IntListConverter implements JsonConverter<List<int>, List<dynamic>> {
  const IntListConverter();

  @override
  List<int> fromJson(List<dynamic> json) {
    return json.map((e) {
      if (e is num) {
        return e.toInt();
      } else if (e is String) {
        return int.parse(e);
      }
      throw TypeError();
    }).toList();
  }

  @override
  List<dynamic> toJson(List<int> object) {
    return object;
  }
}
