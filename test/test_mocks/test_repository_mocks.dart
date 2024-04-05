import 'package:flutter/cupertino.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateNiceMocks(
  [
    MockSpec<SharedPreferences>(),
  ],
)
void load() => debugPrint('loaded');
