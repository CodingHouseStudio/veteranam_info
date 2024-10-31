import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'city_model.freezed.dart';
part 'city_model.g.dart';

@freezed
class CityModel with _$CityModel {
  const factory CityModel({
    required String id,
    @TranslateConverter() required TranslateModel name,
    @TranslateConverter() required TranslateModel region,
  }) = _CityModel;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
}

abstract class CitiesModelJsonField {
  static const id = 'id';
  static const name = 'name';
  static const region = 'region';
}
