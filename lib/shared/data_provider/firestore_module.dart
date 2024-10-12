import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirstoreModule {
  @Singleton(order: -2)
  FirebaseFirestore get dio => FirebaseFirestore.instance;
}
