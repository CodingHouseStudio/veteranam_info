import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:injectable/injectable.dart';

@module
abstract class FirstoreModule {
  @Singleton(order: -2)
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
