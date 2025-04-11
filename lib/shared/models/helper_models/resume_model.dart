import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_model.freezed.dart';
part 'resume_model.g.dart';

@freezed
abstract class ResumeModel with _$ResumeModel {
  const factory ResumeModel({
    required String downloadURL,
    int? lastModifiedTS,
    String? name,
    String? ref,
    String? type,
  }) = _ResumeModel;

  factory ResumeModel.fromJson(Map<String, dynamic> json) =>
      _$ResumeModelFromJson(json);
}

abstract class ResumeModelJsonField {
  static const downloadURL = 'downloadURL';
  static const lastModifiedTS = 'lastModifiedTS';
  static const name = 'name';
  static const ref = 'ref';
  static const type = 'type';
}
