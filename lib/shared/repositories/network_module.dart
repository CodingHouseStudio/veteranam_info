import 'package:connectivity_plus/connectivity_plus.dart' show Connectivity;
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  Connectivity get connectivity => Connectivity();
}
