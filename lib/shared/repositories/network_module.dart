import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @Singleton(order: -3)
  Connectivity get connectivity => Connectivity();
}
