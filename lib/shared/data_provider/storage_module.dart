import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class StorageModule {
  @Singleton(order: -2)
  FirebaseStorage get dio => FirebaseStorage.instance;
}
