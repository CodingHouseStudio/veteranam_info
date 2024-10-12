import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: Class to get, update, delete or set values in storage
@singleton
class StorageService {
  final FirebaseStorage storage = firebaseStorage;

  @visibleForTesting
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<ImageModel?> saveImage({
    required ImagePickerItem imageItem,
    required String id,
    required String collecltionName,
  }) async {
    if (imageItem.bytes.isEmpty) return null;
    final value = storage
        .ref(
          StoragePath.getImagePath(
            collection: collecltionName,
            modelId: id,
            // imageName: imageItem.name,
            imageExtension: imageItem.extension,
          ),
        )
        .putData(imageItem.bytes);
    final snapshot = await value;

    final downloadUrl = await snapshot.ref.getDownloadURL();

    if (downloadUrl.isEmpty) return null;

    return imageItem.image(downloadUrl);
  }

  Future<ResumeModel?> saveRespond({
    required ImagePickerItem resumeItem,
    required String respondId,
  }) async {
    if (resumeItem.bytes.isEmpty) return null;
    final value = storage
        .ref(
          StoragePath.getResumePath(
            collection: FirebaseCollectionName.respond,
            modelId: respondId,
            // resumeName: resumeItem.name,
            fileExtension: resumeItem.extension,
          ),
        )
        .putData(resumeItem.bytes);

    final snapshot = value.snapshot;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    if (downloadUrl.isEmpty) return null;

    return resumeItem.resume(downloadUrl);
  }
}
