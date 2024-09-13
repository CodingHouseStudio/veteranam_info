import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ArtifactModule {
  @Singleton(order: -2)
  Dio get dio => Dio();
}
