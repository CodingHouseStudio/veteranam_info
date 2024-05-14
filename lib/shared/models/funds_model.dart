import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'funds_model.freezed.dart';
part 'funds_model.g.dart';

@freezed
class FundModel with _$FundModel {
  const factory FundModel({
    required String id,
    required String title,
    required String subtitle,
    required String link,
    @ImageConverter() List<ImageModel>? image,
  }) = _FundsModel;

  factory FundModel.fromJson(Map<String, dynamic> json) =>
      _$FundModelFromJson(json);
}
