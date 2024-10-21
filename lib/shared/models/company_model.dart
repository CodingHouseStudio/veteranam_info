import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    required String id,
    required List<String> userEmails,
    String? companyName,
    String? publicName,
    String? code,
    String? link,
    @ImageConverter() ImageModel? image,
  }) = _CompanyModel;

  // Add this private constructor
  const CompanyModel._();

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  static const empty = CompanyModel(id: '', userEmails: []);

  bool get isEmpty =>
      id.isEmpty ||
      companyName == null ||
      companyName!.isEmpty ||
      publicName == null ||
      publicName!.isEmpty ||
      code == null ||
      code!.isEmpty ||
      userEmails.isEmpty
      // ||
      // link == null ||
      // link!.isEmpty
      // ||
      // image == null ||
      // image!.downloadURL.isEmpty
      ;
  bool get isNotEmpty => !isEmpty;
}

abstract class CompanyModelJsonField {
  static const id = 'id';
  static const companyName = 'companyName';
  static const publicName = 'publicName';
  static const userEmails = 'userEmails';
  static const link = 'link';
  static const code = 'code';
  static const image = 'image';
}
