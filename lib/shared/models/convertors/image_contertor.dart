import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

class ImageConverter implements JsonConverter<ImageModel?, List<dynamic>?> {
  const ImageConverter();
  static final ArtifactDownloadHelper _artifactDownloadHelper =
      GetIt.I.get<ArtifactDownloadHelper>();

  @override
  ImageModel? fromJson(List<dynamic>? json) {
    final list = json
        ?.map((e) => ImageModel?.fromJson(e as Map<String, dynamic>))
        .toList();
    if (list?.isEmpty ?? true) {
      return null;
    } else {
      unawaited(_artifactDownloadHelper.downloadArtifacts(list!.first));
      return list.first;
    }
  }

  @override
  List<dynamic>? toJson(ImageModel? object) {
    return object != null ? [object.toJson()] : null;
  }
}
