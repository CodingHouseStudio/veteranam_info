import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: Class to get, update, delete or set values in storage
@singleton
class StorageService {
  final FirebaseStorage storage = firebaseStorage;

  @visibleForTesting
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @visibleForTesting
  static Future<Uint8List>? uint8List;
  Future<Uint8List> _xFile(String ref) async =>
      uint8List ?? XFile(ref).readAsBytes();

  Future<String> saveImage({
    required ImageModel imageModel,
    required String id,
    required String collecltionName,
  }) async {
    if (imageModel.ref == null || imageModel.ref!.isEmpty) return '';
    final value = storage
        .ref(
          StoragePath.getImagePath(
            collection: collecltionName,
            modelId: id,
            imageName: imageModel.name,
          ),
        )
        .putBlob(await _xFile(imageModel.ref!));
    final snapshot = await value.getTaskSnapshot();

    return snapshot.ref.getDownloadURL();
  }

  Future<String> saveUseUint8ListImage({
    required Uint8List image,
    required String id,
    required String collecltionName,
  }) async {
    final value = storage
        .ref(
          StoragePath.getImagePath(
            collection: collecltionName,
            modelId: id,
          ),
        )
        .putImage(image);
    final snapshot = await value.getTaskSnapshot();

    return snapshot.ref.getDownloadURL();
  }

  Future<String?> saveRespond({
    required ResumeModel resumeModel,
    required String respondId,
  }) async {
    if (resumeModel.ref == null && resumeModel.name == null) return null;
    final value = storage
        .ref(
          StoragePath.getResumePath(
            collection: FirebaseCollectionName.respond,
            modelId: respondId,
            resumeName: resumeModel.name,
            fileExtension: resumeModel.name!.substring(
              resumeModel.name!.lastIndexOf('.'),
            ),
          ),
        )
        .putImage(await _xFile(resumeModel.ref!));

    final snapshot = await value.getTaskSnapshot();
    return snapshot.ref.getDownloadURL();
  }
}

extension UploadTaskExtention on UploadTask {
  @visibleForTesting
  static Future<TaskSnapshot>? taskSnapshot;
  Future<TaskSnapshot> getTaskSnapshot() {
    return taskSnapshot ?? this;
  }
}
