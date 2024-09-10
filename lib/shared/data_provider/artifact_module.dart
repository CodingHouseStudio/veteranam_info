import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ArtifactModule {
  @Singleton(order: -2)
  Client get http => Client();
}
