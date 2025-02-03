import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesModule {
  @preResolve
  @Singleton()
  Future<SharedPreferences> get sharedPreferences async =>
      SharedPreferences.getInstance();
}
