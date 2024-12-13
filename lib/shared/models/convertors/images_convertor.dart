import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/data_provider/image_load_helper.dart';
import 'package:veteranam/shared/models/models.dart';

class ImagesConverter
    implements JsonConverter<List<ImageModel>?, List<dynamic>?> {
  const ImagesConverter();
  static final ArtifactDownloadHelper _artifactDownloadHelper =
      GetIt.I.get<ArtifactDownloadHelper>();

  @override
  List<ImageModel>? fromJson(List<dynamic>? json) {
    final list = json
        ?.map((e) => ImageModel?.fromJson(e as Map<String, dynamic>))
        .toList();
    if (list?.isEmpty ?? true) {
      return null;
    } else {
      for (final item in list!) {
        unawaited(_artifactDownloadHelper.downloadArtifacts(item));
      }

      return list;
    }
  }

  @override
  List<dynamic>? toJson(List<ImageModel>? object) {
    return object == null
        ? null
        : List.generate(object.length, (index) => object[index].toJson());
  }
}
