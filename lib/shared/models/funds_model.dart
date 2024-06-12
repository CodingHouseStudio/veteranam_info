import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'funds_model.freezed.dart';
part 'funds_model.g.dart';

@freezed
class FundModel with _$FundModel {
  const factory FundModel({
    required String id,
    required String title,
    required String description,
    required String link,
    required String domain,
    String? registered,
    String? teamPartnersLink,
    String? projectsLink,
    String? email,
    String? phoneNumber,
    String? size,
    String? comments,
    @ImageConverter() List<ImageModel>? image,
  }) = _FundsModel;

  factory FundModel.fromJson(Map<String, dynamic> json) =>
      _$FundModelFromJson(json);
}

abstract class FundModelJsonField {
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const link = 'link';
  static const image = 'image';
  static const domain = 'domain';
  static const registered = 'registered';
  static const teamPartnersLink = 'teamPartnersLink';
  static const projectsLink = 'projectsLink';
  static const email = 'email';
  static const phoneNumber = 'phoneNumber';
  static const size = 'size';
  static const comments = 'comments';
}
