import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

// coverage:ignore-file
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

  Future<String> saveStoryImage({
    required ImageModel imageModel,
    required String storyId,
  }) async {
    if (imageModel.ref == null) return '';
    final value = storage
        .ref(
          StoragePath.getImagePath(
            collenction: FirebaseCollectionName.stroies,
            modelId: storyId,
            imageName: imageModel.name,
          ),
        )
        .putBlob(await _xFile(imageModel.ref!));
    final snapshot = await value.getTaskSnapshot();

    return snapshot.ref.getDownloadURL();
  }
}

extension UploadTaskExtention on UploadTask {
  @visibleForTesting
  static Future<TaskSnapshot>? taskSnapshot;
  Future<TaskSnapshot> getTaskSnapshot() async {
    return taskSnapshot ?? this;
  }
}
