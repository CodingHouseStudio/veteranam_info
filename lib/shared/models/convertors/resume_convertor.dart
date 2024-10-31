import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

class ResumeConverter implements JsonConverter<ResumeModel?, List<dynamic>?> {
  const ResumeConverter();

  @override
  ResumeModel? fromJson(List<dynamic>? json) {
    final list = json
        ?.map((e) => ResumeModel?.fromJson(e as Map<String, dynamic>))
        .toList();
    if (list?.isEmpty ?? true) {
      return null;
    } else {
      return list?.first;
    }
  }

  @override
  List<dynamic>? toJson(ResumeModel? object) {
    return object != null ? [object.toJson()] : null;
  }
}
