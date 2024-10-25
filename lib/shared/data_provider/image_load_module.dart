import 'package:dio/dio.dart' show Dio;
import 'package:injectable/injectable.dart';

@module
abstract class ArtifactModule {
  @Singleton(order: -2)
  Dio get dio => Dio();
}
