import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/test_constants.dart';
import 'package:veteranam/shared/data_provider/image_load_helper.dart';
import 'package:veteranam/shared/models/models.dart';

class ImageConverter implements JsonConverter<ImageModel?, List<dynamic>?> {
  const ImageConverter();
  static final ArtifactDownloadHelper _artifactDownloadHelper =
      GetIt.I.get<ArtifactDownloadHelper>();

  @override
  ImageModel? fromJson(List<dynamic>? json) {
    final list = json == null
        ? null
        : List.generate(
            json.length,
            (index) => ImageModel.fromJson(
              json.elementAt(index) as Map<String, dynamic>,
            ),
          );
    if (list?.isEmpty ?? true) {
      return null;
    } else {
      if (KTest.isTest || Config.isWeb) {
        unawaited(_artifactDownloadHelper.downloadArtifacts(list!.first));
      }

      return list!.first;
    }
  }

  @override
  List<dynamic>? toJson(ImageModel? object) {
    return object != null ? [object.toJson()] : null;
  }
}
