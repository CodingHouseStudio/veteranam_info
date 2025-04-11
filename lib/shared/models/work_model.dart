import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_model.freezed.dart';
part 'work_model.g.dart';

@freezed
sealed class WorkModel with _$WorkModel {
  const factory WorkModel({
    required String id,
    required String title,
    required String price,
    required String employerContact,
    required String companyName,
    required String description,
    String? category,
    String? city,
    @Default(false) bool remote,
  }) = _WorkModel;

  factory WorkModel.fromJson(Map<String, dynamic> json) =>
      _$WorkModelFromJson(json);
}

abstract class WorkModelJsonField {
  static const id = 'id';
  static const title = 'title';
  static const price = 'price';
  static const employerContact = 'employerContact';
  static const companyName = 'companyName';
  static const description = 'description';
  static const category = 'category';
  static const city = 'city';
  static const remote = 'remote';
}
