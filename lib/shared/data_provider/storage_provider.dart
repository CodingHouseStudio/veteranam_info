import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: Class to get, update, delete or set values in storage
@Singleton(order: -1)
class StorageService {
  StorageService(
    this._storage,
  );
  final FirebaseStorage _storage;

  @visibleForTesting
  static void error(Object error) => throw error;

  Future<String?> saveFile({
    required FilePickerItem filePickerItem,
    required String id,
    required String collecltionName,
    String file = StoragePath.image,
    String standartFileExtension = StoragePath.standartImageFileExtension,
  }) async {
    if (filePickerItem.bytes.isEmpty) return null;
    final uploadTask = _storage
        .ref(
          StoragePath.getFilePath(
            collection: collecltionName,
            modelId: id,
            // imageName: imageItem.name,
            fileExtension: filePickerItem.extension, file: file,
            standartFileExtension: standartFileExtension,
          ),
        )
        .putData(filePickerItem.bytes);

    // catchError special for test
    final snapshot = await uploadTask.catchError(error);

    return snapshot.ref.getDownloadURL();
  }

  Future<void> removeFile(
    String? url,
  ) async {
    if (url == null || url.isEmpty) return;
    // We set Try Catch only in the repositories and call it also
    // in the repositories
    await _storage.ref(url).delete();
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
