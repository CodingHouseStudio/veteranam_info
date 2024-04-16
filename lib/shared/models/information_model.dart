import 'package:freezed_annotation/freezed_annotation.dart';

part 'information_model.freezed.dart';
part 'information_model.g.dart';

@freezed
class InformationModel with _$InformationModel {
  const factory InformationModel({
    required String id,
    required String title,
    required String news,
    required DateTime date,
    @Default(<String>[]) List<String>? tags,
    String? image,
  }) = _InformationModel;

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      _$InformationModelFromJson(json);
}
