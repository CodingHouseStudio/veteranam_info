import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

class ResumeConverter
    implements JsonConverter<List<ResumeModel>?, List<dynamic>?> {
  const ResumeConverter();

  @override
  List<ResumeModel>? fromJson(List<dynamic>? json) {
    return json
        ?.map((e) => ResumeModel?.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic>? toJson(List<ResumeModel>? object) {
    return object?.map((e) => e.toJson()).toList();
  }
}
