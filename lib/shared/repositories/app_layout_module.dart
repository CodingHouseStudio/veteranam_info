import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppLayoutModule {
  @singleton
  WidgetsBinding get widgetsBinding => WidgetsBinding.instance;
}
