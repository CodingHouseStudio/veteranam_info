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

  Future<String?> saveFile({
    required ImagePickerItem imagePickerItem,
    required String id,
    required String collecltionName,
  }) async {
    if (imagePickerItem.bytes.isEmpty) return null;
    final value = storage
        .ref(
          StoragePath.getImagePath(
            collection: collecltionName,
            modelId: id,
            // imageName: imageItem.name,
            imageExtension: imagePickerItem.extension,
          ),
        )
        .putData(imagePickerItem.bytes);
    final snapshot = await value;

    return snapshot.ref.getDownloadURL();
  }

  // Future<ResumeModel?> saveRespond({
  //   required ImagePickerItem resumeItem,
  //   required String respondId,
  // }) async {
  //   if (resumeItem.bytes.isEmpty) return null;
  //   final value = storage
  //       .ref(
  //         StoragePath.getResumePath(
  //           collection: FirebaseCollectionName.respond,
  //           modelId: respondId,
  //           // resumeName: resumeItem.name,
  //           fileExtension: resumeItem.extension,
  //         ),
  //       )
  //       .putData(resumeItem.bytes);

  //   final snapshot = value.snapshot;
  //   final downloadUrl = await snapshot.ref.getDownloadURL();

  //   if (downloadUrl.isEmpty) return null;

  //   return resumeItem.resume(downloadUrl);
  // }
}
