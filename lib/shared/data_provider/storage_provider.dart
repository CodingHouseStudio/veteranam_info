import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Class to get, update, delete or set values in storage
@singleton
class StorageService {
  final FirebaseStorage storage = firebaseStorage ?? FirebaseStorage.instance;

  @visibleForTesting
  static FirebaseStorage? firebaseStorage;

  Future<String> saveStoryImage({
    required ImageModel imageModel,
    required String storyId,
  }) async {
    if (imageModel.ref == null) return '';
    final snapshot = await storage
        .ref(
          StoragePath.getImagePath(
            collenction: FirebaseCollectionName.stroies,
            modelId: storyId,
            imageName: imageModel.name,
          ),
        )
        .putBlob(await XFile(imageModel.ref!).readAsBytes());

    return snapshot.ref.getDownloadURL();
  }
}
