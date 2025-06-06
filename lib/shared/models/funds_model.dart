// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'funds_model.freezed.dart';
part 'funds_model.g.dart';

@freezed
abstract class FundModel with _$FundModel {
  const factory FundModel({
    required String id,
    @JsonKey(name: FundModelJsonField.title)
    @TranslateConverter()
    required TranslateModel title,
    @JsonKey(name: FundModelJsonField.description)
    @TranslateConverter()
    required TranslateModel description,
    required String link,
    // required String domain,
    // String? registered,
    // String? teamPartnersLink,
    String? projectsLink,
    // String? email,
    // String? phoneNumber,
    // int? size,
    // String? comments,
    @ImageConverter() ImageModel? image,
  }) = _FundsModel;

  factory FundModel.fromJson(Map<String, dynamic> json) =>
      _$FundModelFromJson(json);
}

abstract class FundModelJsonField {
  static const id = 'id';
  static const title = 'titleT';
  static const titleEN = 'titleEN';
  static const description = 'descriptionT';
  static const descriptionEN = 'descriptionEN';
  static const link = 'link';
  static const image = 'image';
  // static const domain = 'domain';
  // static const registered = 'registered';
  // static const teamPartnersLink = 'teamPartnersLink';
  static const projectsLink = 'projectsLink';
  // static const email = 'email';
  // static const phoneNumber = 'phoneNumber';
  // static const size = 'size';
  // static const comments = 'comments';
}
