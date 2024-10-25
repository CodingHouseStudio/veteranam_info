import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;
import 'package:injectable/injectable.dart';

@module
abstract class StorageModule {
  @Singleton(order: -2)
  FirebaseStorage get storage => FirebaseStorage.instance;
}
